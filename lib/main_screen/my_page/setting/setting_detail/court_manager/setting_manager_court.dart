import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:tennisreminder/model/model_court.dart';

import 'New_Court_register.dart';
import 'edit_court_register.dart';

class SettingManagerCourt extends StatefulWidget {
  const SettingManagerCourt({super.key});

  @override
  State<SettingManagerCourt> createState() => _SettingManagerCourtState();
}

class _SettingManagerCourtState extends State<SettingManagerCourt> {
  late List<ModelCourt> modelCourts;


  @override
  void initState() {
    super.initState();
    modelCourts = []; // 데이터를 담을 리스트 초기화
    _fetchCourtData(); // Firestore에서 데이터 가져오기
  }

  // Firestore에서 데이터를 가져와서 outerModels에 저장하는 메서드
  //이해 잘 안감
  Future<void> _fetchCourtData() async {
    final courtSnapshot = await FirebaseFirestore.instance.collection('court').get();
    final List<ModelCourt> fetchedOuterModels = courtSnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return ModelCourt.fromJson(data);
    }).toList();

    setState(() {
      modelCourts = fetchedOuterModels;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('코트 등록 현황'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewCourtRegister()),
              );
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75,
        ),
        itemCount: modelCourts.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              final updatedModelCourt = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditCourtRegister(modelCourt: modelCourts[index])),
              );

              if (updatedModelCourt != null) {
                setState(() {
                  modelCourts[index] = updatedModelCourt;
                });
              }
            },
            child: Card(
              elevation: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: modelCourts[index].imagePath.isNotEmpty
                        ? Image.file(
                      File(modelCourts[index].imagePath),
                      fit: BoxFit.cover,
                    )
                        : Icon(Icons.image),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          modelCourts[index].name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
