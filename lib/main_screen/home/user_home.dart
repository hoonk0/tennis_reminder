import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tennisreminder/main_screen/home/user_alarm.dart';
import 'package:tennisreminder/main_screen/my_page/search_court/court_favorite.dart';
import 'package:tennisreminder/main_screen/my_town_court/court_gyeonggido.dart';
import 'package:tennisreminder/main_screen/my_town_court/court_seoul.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tennisreminder/model/model_member.dart';
import 'package:tennisreminder/service/provider/providers.dart';
import '../../const/color.dart';
import '../../const/text_style.dart';
import '../../model/model_court.dart';
import '../../start/near_by_court.dart';
import '../my_page/search_court/court_information.dart';
import '../my_page/search_court/court_search.dart';
import '../my_page/setting/setting_page.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

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

      final ModelCourt newModelCourt = ModelCourt.fromJson(event.data()!);

    });
  }

  Future<void> _fetchCourtData() async {
    final courtSnapshot = await FirebaseFirestore.instance.collection('court').get();
    final List<ModelCourt> fetchedModelCourts = courtSnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
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
        backgroundColor: colorWhite,
        title: const Text(
          'COURT VIBE',
          style: TS.s20w700(colorGreen900),
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
                  '원하는 코트 찾아보기',
                  style: TS.s16w600(colorGreen900),
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

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
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
                        MaterialPageRoute(builder: (context) => const CourtSeoul()),
                      );
                    } else if (index == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CourtGyeonggido()),
                      );
                    } else if (index == 2) {}
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    // 각 원의 간격
                    width: 100,
                    height: 20,
                    decoration: BoxDecoration(
                        color: colorGray200,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [BoxShadow(
                          color: Colors.black.withOpacity(0.3), // 검정색 그림자 및 투명도 설정
                          spreadRadius: 1, // 그림자의 확장 범위 설정
                          blurRadius: 3, // 그림자의 흐릿한 정도 설정
                          offset: Offset(0, 1), // 그림자의 위치 설정 (가로: 0, 세로: 3)
                        )]
                    ),
                    child: Center(
                      child: Text(
                        courtName,
                        style: const TS.s14w400(colorGreen900),
                      ),
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
                  '근처 10km 코트 찾기',
                  style: TS.s16w600(colorGreen900),
                ),
              ],
            ),
          ),

          ElevatedButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context)=>NearbyCourts())
            );
          }, child: Text('조회'),),



          ElevatedButton(onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=>SettingPage())
            );
          }, child: Text('테스트'),),

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

