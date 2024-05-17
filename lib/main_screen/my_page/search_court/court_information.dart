import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tennisreminder/const/color.dart';
import 'package:tennisreminder/model/model_court.dart';
import '../../../../../const/text_style.dart';

class CourtInformation extends StatefulWidget {
  final String courtId;

  const CourtInformation({super.key, required this.courtId});

  @override
  State<CourtInformation> createState() => _CourtInformationState();
}

class _CourtInformationState extends State<CourtInformation> {

  Future<ModelCourt?> _fetchCourtDetails() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('court').doc(widget.courtId).get();
      if (doc.exists) {
        return ModelCourt.fromJson(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print("Error fetching court details: $e");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('코트 정보'),
      ),
      body: FutureBuilder<ModelCourt?>(
        future: _fetchCourtDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('에러 발생'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('데이터 없음'));
          }

          ModelCourt court = snapshot.data!;
          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: [

                  //if (_imagePath.isNotEmpty)
                    /*Image.file(
                      File(_imagePath),
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                     */

                  const SizedBox(height: 16),

                  const Text('테니스장명', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(court.name, style: TS.s14w400(colorBlack)),
                  const SizedBox(height: 8),

                  const Text('주소', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(court.location, style: TS.s14w400(colorBlack)),
                  const SizedBox(height: 8),

                  const Text('전화번호', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(court.phone, style: TS.s14w400(colorBlack)),
                  const SizedBox(height: 8),

                  const Text('예약사이트 바로가기', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(court.website, style: TS.s14w400(colorBlack)),
                  const SizedBox(height: 8),

                  const Text('안내사항', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(court.notice, style: TS.s14w400(colorBlack)),
                  const SizedBox(height: 8),

                  const Text('코트 정보', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(court.information, style: TS.s14w400(colorBlack)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
