import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tennisreminder/const/color.dart';
import 'package:tennisreminder/model/model_court.dart';
import '../../const/text_style.dart';
import '../my_page/search_court/court_information.dart';

class CourtGyeonggido extends StatefulWidget {
  const CourtGyeonggido({Key? key}) : super(key: key);

  @override
  _CourtGyeonggidoState createState() => _CourtGyeonggidoState();
}

class _CourtGyeonggidoState extends State<CourtGyeonggido> {
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
        .where('location', isGreaterThanOrEqualTo: '경기도', isLessThan: '경기도' + String.fromCharCode('경기도'.codeUnitAt(0) + 1)) // '서울시'로 시작하는 location
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
          '경기도 코트',
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
