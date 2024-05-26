import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tennisreminder/const/color.dart';
import 'package:tennisreminder/model/model_court.dart';

import '../my_page/search_court/court_information.dart';


class CourtSeoul extends StatefulWidget {
  const CourtSeoul({Key? key}) : super(key: key);

  @override
  _CourtSeoulState createState() => _CourtSeoulState();
}

class _CourtSeoulState extends State<CourtSeoul> {
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
        .where('location', isGreaterThanOrEqualTo: '서울시', isLessThan: '서울시' + String.fromCharCode('서울시'.codeUnitAt(0) + 1)) // '서울시'로 시작하는 location 필드를 가져옴
        .get();
    setState(() {
      _courts = querySnapshot.docs.map((doc) => ModelCourt.fromJson(doc.data() as Map<String, dynamic>)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('서울시 코트'),
      ),
      body: ListView.builder(
        itemCount: _courts.length,
        itemBuilder: (context, index) {
          ModelCourt court = _courts[index];
          return ListTile(
            title: Text(court.name),
            subtitle: Text(court.location),
            onTap: () async {
              final watchModelCourt = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CourtInformation(courtId: _courts[index].id)),
              );
            },
          );
        },
      ),
    );
  }
}
