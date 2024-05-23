/*
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class MapScreen extends StatefulWidget {

  const MapScreen({super.key, });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {


  final CameraPosition initialPosition = CameraPosition(
    target: LatLng(
      37.4877404,
      127.0765455
    ),
    zoom: 15,
  );

  bool canChoolCheck = false;

  final double okDistance = 100;

  late final GoogleMapController controller;

  @override
  initState(){
    super.initState();

    Geolocator.getPositionStream().listen((event){
      final start = LatLng(
          37.4877404,
          127.0765455
      );
      final end = LatLng(event.latitude, event.longitude );
      final distance = Geolocator.distanceBetween(start.latitude, start.longitude, end.latitude, end.longitude);

      setState(() {
        if(distance> okDistance){
          canChoolCheck = false;
        }else{
          canChoolCheck = true;
        }
      });
    });
  }


  checkPermission() async {
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if(!isLocationEnabled){
      throw Exception('위치 기능을 활성화 해주세요');
    }
    LocationPermission checkedPermission = await Geolocator.checkPermission();

    if(checkedPermission == LocationPermission.denied){
      checkedPermission = await Geolocator.requestPermission();
    }

    if(checkedPermission != LocationPermission.always &&
    checkedPermission != LocationPermission.whileInUse) {
      throw Exception('위치 권한을 허가해주세요.');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('위치'),
        actions: [
          IconButton(
            onPressed: myLocationPressed,
            icon: Icon(Icons.my_location),
            color: Colors.blue,
          ),
        ],
      ),
      body: FutureBuilder(
        future: checkPermission(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasError){
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return Column(
            children: [
              Expanded(
                  child: GoogleMap(
                    initialCameraPosition: initialPosition,
                    myLocationButtonEnabled: true,
                    zoomControlsEnabled: false,
                    myLocationEnabled: true,
                    onMapCreated: (GoogleMapController controller){
                      this.controller = controller;
                    },
                    markers:{
                      Marker(
                        markerId: MarkerId('123'),
                        position: LatLng(
                            37.48775,
                            127.0765455
                        ),
                      ),
                    },
                    circles: {
                      Circle(
                        circleId: CircleId('inDistance'),
                        center: LatLng(
                            37.4877404,
                            127.0765455
                        ),
                        radius: okDistance,
                        fillColor: Colors.blue.withOpacity(0.5),
                        strokeColor: Colors.blue,
                        strokeWidth: 1,
                    ),
                    },
              ),
              )
            ],
          );
        }
      )
    );
  }
  myLocationPressed() async {
    final location = await Geolocator.getCurrentPosition();

    controller.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(
          location.latitude,
          location.longitude
        ),
      ),
    );

  }
}
*/