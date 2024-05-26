import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../model/model_court.dart';
import '../../../const/color.dart';  // 색상 상수 파일 경로에 따라 수정

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
      // 10킬로미터 이내의 코트만 추가합니다.
      if (distance <= 10) {
        courts.add(court);
      }
    }

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
      appBar: AppBar(
        title: Text('Nearby Courts'),
      ),
      body: _currentLocation != null
          ? ListView.builder(
        itemCount: _nearbyCourts.length,
        itemBuilder: (context, index) {
          ModelCourt court = _nearbyCourts[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: colorGreen900, width: 2),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text(
                  court.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(court.location),
              ),
            ),
          );
        },
      )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
