import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../model/model_court.dart';
import '../../../const/color.dart';
import '../const/text_style.dart';  // 색상 상수 파일 경로에 따라 수정

class NearbyCourts extends StatefulWidget {
  @override
  _NearbyCourtsState createState() => _NearbyCourtsState();
}

class _NearbyCourtsState extends State<NearbyCourts> {
  final Location _location = Location();
  LocationData? _currentLocation;
  StreamSubscription<LocationData>? _locationSubscription;
  List<ModelCourt> _nearbyCourts = [];

  @override
  void initState() {
    super.initState();
    _initCurrentLocation();
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    super.dispose();
  }

  Future<void> _initCurrentLocation() async {
    try {
      _currentLocation = await _location.getLocation();
      _loadNearbyCourts(_currentLocation!.latitude!, _currentLocation!.longitude!);
      _locationSubscription = _location.onLocationChanged.listen((LocationData currentLocation) {
        setState(() {
          _currentLocation = currentLocation;
        });
        _loadNearbyCourts(currentLocation.latitude!, currentLocation.longitude!);
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  Future<void> _loadNearbyCourts(double latitude, double longitude) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('court').get();
    List<ModelCourt> courts = [];

    for (final doc in snapshot.docs) {
      final ModelCourt court = ModelCourt.fromJson(doc.data() as Map<String, dynamic>);
      final double distance = _calculateDistance(latitude, longitude, court.courtLat, court.courtLng);
      if (distance <= 100) { //10으로 수정필요
        courts.add(court);
      }
    }

    // 거리에 따라 정렬하여 가까운 코트를 맨 위에 표시
    courts.sort((a, b) => _calculateDistance(latitude, longitude, a.courtLat, a.courtLng)
        .compareTo(_calculateDistance(latitude, longitude, b.courtLat, b.courtLng)));

    setState(() {
      _nearbyCourts = courts;
    });
  }

  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double radius = 6371; // 지구의 반지름 (단위: km)
    double dLat = _degreesToRadians(lat2 - lat1);
    double dLon = _degreesToRadians(lon2 - lon1);
    double a =
        (sin(dLat / 2) * sin(dLat / 2)) +
            (cos(_degreesToRadians(lat1)) * cos(_degreesToRadians(lat2)) * sin(dLon / 2) * sin(dLon / 2));
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = radius * c;
    return distance;
  }

  double _degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentLocation != null
          ? ListView.builder(
        itemCount: _nearbyCourts.length,
        itemBuilder: (context, index) {
          ModelCourt court = _nearbyCourts[index];
          final double distance = _calculateDistance(
            _currentLocation!.latitude!,
            _currentLocation!.longitude!,
            court.courtLat,
            court.courtLng,
          );

          return Column(
            children: [
              if (index == 0)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Divider(color: colorGray400),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    minTileHeight: 10,
                    title: Text(
                      court.name,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          court.location,
                          style: TS.s12w400(colorGray600),
                        ),
                        SizedBox(height: 6),
                        Text('${distance.toStringAsFixed(2)} km'),
                      ],
                    ),
                  ),
              ),
              if (index < _nearbyCourts.length - 1)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Divider(color: colorGray400),
                ),
            ],
          );
        },
      )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
