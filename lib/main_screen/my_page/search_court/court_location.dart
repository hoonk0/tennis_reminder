import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../model/model_court.dart'; // 모델 파일의 경로에 따라 수정하세요

class CourtLocation extends StatefulWidget {
  final CameraPosition initialPosition;

  const CourtLocation({Key? key, required this.initialPosition}) : super(key: key);

  @override
  State<CourtLocation> createState() => _CourtLocationState();
}

class _CourtLocationState extends State<CourtLocation> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    loadCourtLocations();
  }

  Future<void> loadCourtLocations() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('court').get();

    setState(() {
      _markers.clear(); // 이전 마커를 모두 제거합니다.
      for (final doc in snapshot.docs) {
        final ModelCourt court = ModelCourt.fromJson(doc.data() as Map<String, dynamic>);
        _markers.add(
          Marker(
            markerId: MarkerId(court.id),
            position: LatLng(
              court.courtLat,
              court.courtLng,
            ),
            infoWindow: InfoWindow(
              title: court.name,
              snippet: court.location,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: (controller) {
                _mapController = controller;
              },
              markers: _markers,
              initialCameraPosition: widget.initialPosition,
            ),
          ),
        ],
      ),
    );
  }
}
