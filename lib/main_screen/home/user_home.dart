import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    final pref = await SharedPreferences.getInstance();
    final userId = pref.getString('uid');

    /// 문서가 업데이트 될 때마다 계속 받아옴(일회성으로 받아올 필요가 없다.)
    streamSub = FirebaseFirestore.instance.collection('member').doc(userId).snapshots().listen((event) {
      final ModelMember newModelMember = ModelMember.fromJson(event.data()!);
      userNotifier.value = newModelMember;
      debugPrint("유저정보 업데이트 ${userNotifier.value!.toJson()}");
    });
  }

  Future<void> _fetchCourtData() async {
    // 시작시간
    final now = DateTime.now();
    debugPrint("시작시간 $now");
    final courtSnapshot = await FirebaseFirestore.instance.collection('court').get();
    final List<ModelCourt> fetchedModelCourts = courtSnapshot.docs.map((doc) {
      final data = doc.data();
      return ModelCourt.fromJson(data);
    }).toList();
    // 경과시간
    final elapsed = DateTime.now().difference(now);
    debugPrint("경과시간 $elapsed");

    // 1. 현재 위젯트리를 dispose 안되게 하는 방법
    // 2. final courtSnapshot = await FirebaseFirestore.instance.collection('court').get();를 끝마치고서 이 위젯트리로 오게
    // 3. Widget Tree에 살아있을때만 실행
    debugPrint("mounted $mounted");
    if (mounted) {
      setState(() {
        modelCourts = fetchedModelCourts;
      });
    } else {
      debugPrint("위젯트리 죽음");
    }
  }

  Future<void> _loadNearbyCourts() async {
    // TODO: 근처 코트 데이터를 로드하고 화면에 표시하는 기능 구현
    // 여기에 코드를 추가하세요.
  }

  @override
  void dispose() {
    debugPrint("UserHome dispose");
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
            textStyle: const TextStyle(
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
                  'ㅇSEARCH COURT',
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
          const Expanded(
            child: NearbyCourts(),
          ),
        ],
      ),
    );
  }
}
