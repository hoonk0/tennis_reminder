import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tennisreminder/main_screen/home/user_alarm.dart';
import 'package:tennisreminder/main_screen/my_page/search_court/court_favorite.dart';
import 'package:tennisreminder/main_screen/my_town_court/court_incheon.dart';
import 'package:tennisreminder/main_screen/my_town_court/court_kyungki.dart';
import 'package:tennisreminder/main_screen/my_town_court/court_seoul.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../const/color.dart';
import '../../const/text_style.dart';
import '../../model/model_court.dart';
import '../my_page/search_court/court_information.dart';
import '../my_page/search_court/court_search.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  late List<ModelCourt> modelCourts;

  @override
  void initState() {
    super.initState();
    modelCourts = []; // 데이터를 담을 리스트 초기화
    _fetchCourtData(); // Firestore에서 데이터 가져오기
  }

  Future<void> _fetchCourtData() async {
    final courtSnapshot =
    await FirebaseFirestore.instance.collection('court').get();
    final List<ModelCourt> fetchedOuterModels = courtSnapshot.docs.map((doc) {
      final data = doc.data();
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
        automaticallyImplyLeading: false,
        backgroundColor: colorWhite,
        title: Text(
          'COURT VIBE',
          style: TS.s20w700(colorGreen900),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=>CourtSearch()),
              );
            },
            icon: const Icon(Icons.search_rounded),
            color: colorGreen900,
          ),
          IconButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=>UserAlarm()),
              );
            },
            icon: const Icon(Icons.notifications),
            color: colorGreen900,
          ),
          IconButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=>CourtFavorite()),
              );
            },
            icon: const Icon(Icons.favorite_border_rounded),
            color: colorGreen900,
          ),
        ],

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //Container(height: 10, color: colorGray300),
          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '원하는 코트 찾아보기',
                  style: TS.s16w600(colorGreen900),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CourtSearch()),
                    );
                  },
                  icon: const Icon(Icons.arrow_forward),
                  color: colorGreen900,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 150,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1,
              ),
              itemCount: modelCourts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    final watchModelCourt = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CourtInformation(
                            courtId: modelCourts[index].id,
                          )),
                    );

                    if (watchModelCourt != null) {
                      setState(() {
                        modelCourts[index] = watchModelCourt;
                      });
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: modelCourts[index].imagePath.isNotEmpty
                              ? Image.file(
                            File(modelCourts[index].imagePath),
                            fit: BoxFit.cover,
                          )
                              : const Icon(Icons.image),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                modelCourts[index].name,
                                style: const TS.s12w400(colorGreen900),
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
          ),

          const SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Text(
                  '우리동네 코트 찾기',
                  style: TS.s16w600(colorGreen900),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 40,
            child: ListView.builder(
              padding: EdgeInsets.zero, // 원 사이의 간격 없애기
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                String courtName = '';
                if (index == 0) {
                  courtName = '서울';
                } else if (index == 1) {
                  courtName = '경기';
                } else if (index == 2) {
                  courtName = '인천';
                }
                return GestureDetector(
                  onTap: () {
                    if (index == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CourtSeoul()),
                      );
                    } else if (index == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CourtKyungki()),
                      );
                    } else if (index == 2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CourtIncheon()),
                      );
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4), // 각 원의 간격
                    width: 100,
                    height: 20,
                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(120), // 원 모양으로 설정
                      color: colorWhite,
                      border: Border.all(color: colorGreen900, width: 2), // 테두리 색상 및 두께 지정
                    ),
                    child: Center(
                      child: Text(
                        courtName,
                        style: TS.s14w400(colorGreen900),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),


          const SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      '내 주변 코트 추천',
                      style: TS.s16w600(colorGreen900),
                    ),
                  ],
                ),

                SizedBox(
                  height: 200,
                  width: 1600,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 5), // 원 사이의 간격 없애기
                    scrollDirection: Axis.vertical,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      String courtName = '';
                      if (index == 0) {
                        courtName = '서울 \n 올림픽공원';
                      } else if (index == 1) {
                        courtName = '경기';
                      } else if (index == 2) {
                        courtName = '인천';
                      }
                      return GestureDetector(
                        onTap: () {
                          if (index == 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CourtSeoul()),
                            );
                          } else if (index == 1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CourtKyungki()),
                            );
                          } else if (index == 2) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CourtIncheon()),
                            );
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10), // 각 원의 간격
                          width: 200,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5), // 원 모양으로 설정
                            color: colorWhite,
                            border: Border.all(color: colorGreen900, width: 2), // 테두리 색상 및 두께 지정
                          ),
                          child: Center(
                            child: Text(
                              courtName,
                              style: TS.s16w400(colorGreen900),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
