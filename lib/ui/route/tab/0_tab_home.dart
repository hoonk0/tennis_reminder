import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tennisreminder/ui/bottom_sheet/bottom_sheet_name_filter.dart';
import 'package:tennisreminder/ui/component/container_court_column.dart';
import '../../../const/enum/enums.dart';
import '../../../const/model/model_court.dart';
import '../../../const/model/model_user.dart';
import '../../../const/value/colors.dart';
import '../../../const/value/gaps.dart';
import '../../../const/value/text_style.dart';
import '../../../service/provider/providers.dart';
import '../home/court_map/neartby_courts_map.dart';
import '../home/court_search/court_information.dart';
import '../home/court_search/court_search.dart';

class TabHome extends StatefulWidget {
  const TabHome({super.key});

  @override
  State<TabHome> createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> {
  late List<ModelCourt> modelCourts;
  StreamSubscription? streamSub;

  final ValueNotifier<SeoulDistrict?> vnLocationGuSelected = ValueNotifier<SeoulDistrict?>(null);

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

    if (userId == null) {
      debugPrint("userId가 null입니다.");
      return; // null이면 바로 종료
    }

    streamSub = FirebaseFirestore.instance
        .collection('user')
        .doc(userId)
        .snapshots()
        .listen((event) {
      final data = event.data();
      if (data != null) {
        final ModelUser newModelUser = ModelUser.fromJson(data);
        userNotifier.value = newModelUser;
        debugPrint("유저정보 업데이트 ${userNotifier.value!.toJson()}");
      } else {
        debugPrint("Firestore 문서 데이터가 null입니다.");
      }
    }, onError: (error) {
      debugPrint("Firestore 오류 발생: $error");
    });
  }

  Future<void> _fetchCourtData() async {
    // 시작시간
    final now = DateTime.now();
    debugPrint("시작시간 $now");
    final courtSnapshot =
        await FirebaseFirestore.instance.collection('court').get();
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
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ///코트 검색 화면
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CourtSearch()));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: colorWhite,
                    border: Border.all(color: colorGreen900, width: 2),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start, // 좌측 정렬
                    children: [
                      // 돋보기 아이콘 추가
                      Icon(
                        Icons.search, // Flutter 기본 아이콘 중 검색 아이콘 사용
                        color: colorGray900, // 아이콘 색상 설정
                        size: 20, // 아이콘 크기 조정 (필요에 따라 조정)
                      ),
                      SizedBox(width: 4), // 아이콘과 텍스트 사이의 간격 추가
                      Text(
                        '원하는 코트를 검색하세요.',
                        style: TS.s13w500(colorGray900),
                      ),
                    ],
                  ),
                ),
              ),
              Gaps.v10,

              ///필터
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return BottomSheetNameFilter(
                          vnSelectedFilterList: vnLocationGuSelected,
                        );
                      });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: colorBlack),
                  ),
                  child: ValueListenableBuilder<SeoulDistrict?>(
                    valueListenable: vnLocationGuSelected, // ValueListenableBuilder 추가
                    builder: (context, value, child) {
                      return Text(
                        value != null
                            ? seoulDistrictKorean[value]!
                            : '선택', // ValueListenableBuilder에 따라 텍스트 변경
                      );
                    },
                  ), // 변경된 부분
                ),
              ),
              Gaps.v10,

              ///코트 나열
              CourtGridView(listCourt: modelCourts),


            ],
          ),
        ),
      ),
    );
  }
}
