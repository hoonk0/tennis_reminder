import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tennisreminder/main_screen/home/user_alarm.dart';
import 'package:tennisreminder/main_screen/my_page/search_court/court_favorite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tennisreminder/model/model_member.dart';
import 'package:tennisreminder/service/provider/providers.dart';
import '../../const/color.dart';
import '../../const/text_style.dart';
import '../../model/model_court.dart';
import '../../start/near_by_court.dart';
import '../my_page/search_court/court_information.dart';
import '../my_page/search_court/court_search.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  late List<ModelCourt> modelCourts;
  StreamSubscription? streamSub;

  @override
  void initState() {
    super.initState();
    modelCourts = []; // 데이터를 담을 리스트 초기화
    _fetchCourtData(); // Firestore에서 데이터 가져오기
    streamMe();
    _loadNearbyCourts(); // 근처 코트 데이터 로드
  }

  Future<void> streamMe() async {
    streamSub = FirebaseFirestore.instance.collection('member').doc(userNotifier.value!.id).snapshots().listen((event) {
      final ModelMember newModelMember = ModelMember.fromJson(event.data()!);
      userNotifier.value = newModelMember;
      debugPrint("유저정보 업데이트 ${userNotifier.value!.toJson()}");
    });
  }

  Future<void> _fetchCourtData() async {
    final courtSnapshot = await FirebaseFirestore.instance.collection('court').get();
    final List<ModelCourt> fetchedModelCourts = courtSnapshot.docs.map((doc) {
      final data = doc.data();
      return ModelCourt.fromJson(data);
    }).toList();

    setState(() {
      modelCourts = fetchedModelCourts;
    });
  }

  Future<void> _loadNearbyCourts() async {
    // TODO: 근처 코트 데이터를 로드하고 화면에 표시하는 기능 구현
    // 여기에 코드를 추가하세요.
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    streamSub?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffe8e8e8),
        title: Text(
          'COURT VIBE',
          style: GoogleFonts.anton(
            textStyle: TextStyle(
              fontWeight: FontWeight.w400,
              color: colorGreen900,
              fontSize: 24,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CourtSearch()),
              );
            },
            icon: const Icon(Icons.search_rounded),
            color: colorGreen900,
          ),
          IconButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserAlarm()),
              );
            },
            icon: const Icon(Icons.notifications),
            color: colorGreen900,
          ),
          IconButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CourtFavorite()),
              );
            },
            icon: const Icon(Icons.star_border_outlined),
            color: colorGreen900,
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'SEARCH COURT',
                  style: TS.s16w900(colorGreen900),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CourtSearch()),
                    );
                  },
                  icon: const Icon(Icons.arrow_forward),
                  color: colorGreen900,
                ),
              ],
            ),
          ),
          /*
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [

                GestureDetector(
                  onTap: () {
                    setState(() {
                      // 모든 코트를 표시하기 위해 초기 데이터로 설정
                      _fetchCourtData();
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: colorGray400),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Text(
                      '전체',
                      style: TS.s14w600(colorBlack),
                    ),
                  ),
                ),

                SizedBox(width: 8),

                GestureDetector(
                  onTap: () async {
                    // 서울시 코트만 필터링하여 표시
                    setState(() {
                      modelCourts = modelCourts.where((court) => court.location.startsWith('서울시')).toList();
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white, // 완전한 흰색 배경
                      border: Border.all(color: colorGray400), // 회색 테두리
                      borderRadius: BorderRadius.circular(100), // 10의 반지름을 가진 둥근 테두리
                    ),
                    child: Text(
                      '서울',
                      style: TS.s14w600(colorBlack),
                    ),
                  ),
                ),

                SizedBox(width: 8), // 각 컨테이너 사이의 간격

                GestureDetector(
                  onTap: () async {
                    // 경기도 코트만 필터링하여 표시
                    setState(() {
                      modelCourts = modelCourts.where((court) => court.location.startsWith('경기도')).toList();
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white, // 완전한 흰색 배경
                      border: Border.all(color: colorGray400), // 회색 테두리
                      borderRadius: BorderRadius.circular(100), // 10의 반지름을 가진 둥근 테두리
                    ),
                    child: Text(
                      '경기',
                      style: TS.s14w600(colorBlack),
                    ),
                  ),
                ),


                SizedBox(width: 8),

                GestureDetector(
                  onTap: () async {
                    // 서울시 코트만 필터링하여 표시
                    setState(() {
                      modelCourts = modelCourts.where((court) => court.location.startsWith('인천시')).toList();
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white, // 완전한 흰색 배경
                      border: Border.all(color: colorGray400), // 회색 테두리
                      borderRadius: BorderRadius.circular(100), // 10의 반지름을 가진 둥근 테두리
                    ),
                    child: Text(
                      '인천',
                      style: TS.s14w600(colorBlack),
                    ),
                  ),
                ),


                SizedBox(width: 8),

              ],
            ),
          ),
                */

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
                              ? Image.network(
                                  modelCourts[index].imagePath,
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
                                style: const TS.s12w600(colorBlack),
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  'NEARBY 10KM',
                  style: TS.s16w900(colorGreen900),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: NearbyCourts(),
            ),
          ),

/*
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '근처 코트',
                  style: TS.s16w600(colorGreen900),
                ),
                const SizedBox(height: 10),
                // 근처 코트 데이터 표시
                Expanded(
                  child: NearbyCourts(), // 이 부분에 NearbyCourts 위젯을 추가합니다.
                ),
              ],
            ),
          ),

 */
        ],
      ),
    );
  }
}
