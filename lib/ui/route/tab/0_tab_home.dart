import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tennisreminder/ui/bottom_sheet/bottom_sheet_name_filter.dart';
import 'package:tennisreminder/ui/bottom_sheet/bottom_sheet_parking_filter.dart';
import 'package:tennisreminder/ui/component/container_court_column.dart';
import '../../../const/enum/enums.dart';
import '../../../const/model/model_court.dart';
import '../../../const/value/colors.dart';
import '../../../const/value/gaps.dart';


class TabHome extends StatefulWidget {
  const TabHome({super.key});

  @override
  State<TabHome> createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> {
  late List<ModelCourt> modelCourts;
  List<ModelCourt> filteredCourts = []; // 필터링된 코트 리스트
  StreamSubscription? streamSub;

  // 초기값을 null로 설정
  final ValueNotifier<List<SeoulDistrict>> vnLocationGuSelected = ValueNotifier<List<SeoulDistrict>>([]);
  final ValueNotifier<bool?> vnParkingSelected = ValueNotifier<bool?>(null); // 초기값을 null로 설정

  @override
  void initState() {
    super.initState();
    modelCourts = [];
    _fetchCourtData();
  }

  Future<void> _fetchCourtData() async {
    final courtSnapshot = await FirebaseFirestore.instance.collection('court').get();
    final List<ModelCourt> fetchedModelCourts = courtSnapshot.docs.map((doc) {
      final data = doc.data();
      return ModelCourt.fromJson(data);
    }).toList();

    if (mounted) {
      setState(() {
        modelCourts = fetchedModelCourts;
        _filterCourts(); // 초기 필터링 실행
      });
    }
  }

  // 선택된 구에 맞게 코트 필터링하는 메서드
  void _filterCourts() {
    final selectedGus = vnLocationGuSelected.value;
    final isParkingSelected = vnParkingSelected.value; // 주차장 필터링 체크

    setState(() {
      // 필터링 로직
      filteredCourts = modelCourts.where((court) {
        final locationWords = court.location.split(' ');
        final matchesDistrict = selectedGus.isEmpty ||
            (locationWords.length > 1 && selectedGus.any((gu) => locationWords[1] == seoulDistrictKorean[gu]!));

        // 주차장 필터링 추가
        final matchesParking = isParkingSelected == null ||
            (isParkingSelected == true && court.parking == true) ||
            (isParkingSelected == false && court.parking == false);

        return matchesDistrict && matchesParking; // 두 조건을 모두 만족해야 함
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              // 필터 UI
              Row(
                children: [
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
                      child: ValueListenableBuilder<List<SeoulDistrict>>(
                        valueListenable: vnLocationGuSelected,
                        builder: (context, selectedGus, child) {
                          WidgetsBinding.instance.addPostFrameCallback((_) => _filterCourts());
                          return Text(
                            selectedGus.isNotEmpty
                                ? selectedGus.map((gu) => seoulDistrictKorean[gu]!).join(', ')  // 선택된 구 목록 표시
                                : '지역',
                          );
                        },
                      ),
                    ),
                  ),

                  Gaps.h10,
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return BottomSheetParkingFilter(
                            vnSelectedFilter: vnParkingSelected,
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: colorBlack),
                      ),
                      child: ValueListenableBuilder<bool?>(
                        valueListenable: vnParkingSelected,
                        builder: (context, selectedParking, child) {
                          WidgetsBinding.instance.addPostFrameCallback((_) => _filterCourts());
                          return Text(
                            selectedParking == true
                                ? '주차장 있음'  // 주차장이 있는 경우
                                : selectedParking == false
                                ? '주차장 없음'  // 주차장이 없는 경우
                                : '주차장',  // 선택되지 않은 경우
                          );
                        },
                      ),
                    ),
                  ),

                ],
              ),
              Gaps.v10,

              // 필터링된 코트 나열
              CourtGridView(listCourt: filteredCourts),
            ],
          ),
        ),
      ),
    );
  }
}
