import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyLocation extends StatefulWidget {
  const MyLocation({Key? key}) : super(key: key);

  @override
  State<MyLocation> createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {
  final CameraPosition initialPosition = const CameraPosition(
    target: LatLng(37.4877404, 127.0765455),
    zoom: 15,
  );

  bool canChoolCheck = false;
  final double okDistance = 100;
  late final GoogleMapController myLocationController;

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  Future<void> checkPermission() async {
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      throw Exception('위치 기능을 활성화 해주세요');
    }
    LocationPermission checkedPermission = await Geolocator.checkPermission();
    if (checkedPermission == LocationPermission.denied) {
      checkedPermission = await Geolocator.requestPermission();
    }
    if (checkedPermission != LocationPermission.always &&
        checkedPermission != LocationPermission.whileInUse) {
      throw Exception('위치 권한을 허가해주세요.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('위치'),
        actions: [
          IconButton(
            onPressed: myLocationPressed,
            icon: const Icon(Icons.my_location),
            color: Colors.blue,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: initialPosition,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: false,
              myLocationEnabled: true,
              onMapCreated: (GoogleMapController myLocationController) {
                this.myLocationController = myLocationController;
              },
              markers: {
                Marker(
                  markerId: const MarkerId('123'),
                  position: const LatLng(37.48775, 127.0765455),
                ),
              },
              circles: {
                Circle(
                  circleId: const CircleId('inDistance'),
                  center: const LatLng(37.4877404, 127.0765455),
                  radius: okDistance,
                  fillColor: Colors.blue.withOpacity(0.5),
                  strokeColor: Colors.blue,
                  strokeWidth: 1,
                ),
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> myLocationPressed() async {
    final location = await Geolocator.getCurrentPosition();

    myLocationController.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(
          location.latitude,
          location.longitude,
        ),
      ),
    );
  }

  @override
  void dispose() {
    myLocationController.dispose();
    super.dispose();
  }
}
