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
  List<ModelCourt> filteredCourts = []; // 필터링된 코트 리스트
  StreamSubscription? streamSub;

  // 여러 구를 선택할 수 있도록 ValueNotifier를 List로 변경
  final ValueNotifier<List<SeoulDistrict>> vnLocationGuSelected = ValueNotifier<List<SeoulDistrict>>([]);

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
    setState(() {
      if (selectedGus.isEmpty) {
        filteredCourts = modelCourts; // 선택된 구가 없으면 모든 코트를 표시
      } else {
        filteredCourts = modelCourts.where((court) {
          final locationWords = court.location.split(' ');
          return locationWords.length > 1 && selectedGus.any((gu) => locationWords[1] == seoulDistrictKorean[gu]!);
        }).toList();
      }
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
                            : '선택',
                      );
                    },
                  ),
                ),
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
