import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tennisreminder/const/color.dart';
import 'package:tennisreminder/model/model_court.dart';
import '../../const/text_style.dart';
import '../my_page/search_court/court_information.dart';

class CourtIncheon extends StatefulWidget {
  const CourtIncheon({Key? key}) : super(key: key);

  @override
  _CourtIncheonState createState() => _CourtIncheonState();
}

class _CourtIncheonState extends State<CourtIncheon> {
  List<ModelCourt> _courts = []; // 서울시에 위치한 코트 목록

  @override
  void initState() {
    super.initState();
    _fetchSeoulCourts(); // 화면이 처음 로드될 때 서울시에 위치한 코트 데이터를 가져옴
  }

  Future<void> _fetchSeoulCourts() async {
    // Firestore에서 서울시에 위치한 코트 데이터를 가져오는 함수
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('court')
        .where('location', isGreaterThanOrEqualTo: '인천시', isLessThan: '인천시' + String.fromCharCode('인천시'.codeUnitAt(0) + 1)) // '서울시'로 시작하는
    // location
    // 필드를 가져옴
        .get();
    setState(() {
      _courts = querySnapshot.docs.map((doc) => ModelCourt.fromJson(doc.data() as Map<String, dynamic>)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  const Color(0xffe8e8e8),
        centerTitle: true,
        title: const Text(
          '인천 코트',
          style: TS.s20w700(colorGreen900),
        ),
      ),
      body: ListView.builder(
        itemCount: _courts.length,
        itemBuilder: (context, index) {
          ModelCourt court = _courts[index];
          return GestureDetector(
            onTap: () async {
              final watchModelCourt = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CourtInformation(courtId: _courts[index].id)),
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: const Color(0xff719a93),
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text(
                  court.name,
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  court.location,
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
