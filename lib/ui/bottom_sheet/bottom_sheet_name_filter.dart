import 'package:flutter/material.dart';
import '../../const/enum/enums.dart';
import '../../const/value/colors.dart';
import '../../const/value/gaps.dart';
import '../../const/value/text_style.dart';
import '../component/button_basic.dart';
import '../component/custom_checkbox_container.dart';

class BottomSheetNameFilter extends StatelessWidget {
  final ValueNotifier<List<SeoulDistrict>> vnSelectedFilterList;

  const BottomSheetNameFilter({
    super.key,
    required this.vnSelectedFilterList,
  });

  @override
  Widget build(BuildContext context) {
    // 선택된 구를 임시로 저장할 ValueNotifier
    ValueNotifier<List<SeoulDistrict>> tempSelectedDistricts =
        ValueNotifier<List<SeoulDistrict>>(
            List.from(vnSelectedFilterList.value));

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// 상단 막대
          Container(
            width: 44,
            height: 4,
            margin: const EdgeInsets.only(top: 12.0),
            decoration: BoxDecoration(
              color: colorGray300,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          Gaps.v16,
          const Text('필터', style: TS.s18w600(Color(0xff222222))),
          Gaps.v20,

          /// 필터
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: ValueListenableBuilder<List<SeoulDistrict>>(
                  valueListenable: tempSelectedDistricts,
                  builder: (context, selectedDistricts, child) {
                    return Column(
                      children: SeoulDistrict.values.map((district) {
                        final isSelected = selectedDistricts.contains(district);
                        return CustomCheckboxContainer(
                          title: seoulDistrictKorean[district]!,
                          isSelected: isSelected,
                          onTap: () {
                            if (isSelected) {
                              selectedDistricts.remove(district); // 선택 해제
                            } else {
                              selectedDistricts.add(district); // 선택
                            }
                            tempSelectedDistricts.value =
                                List.from(selectedDistricts); // 업데이트
                          },
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ),
          ),

          Gaps.v16,
          Row(
            children: [
              Gaps.h10,
              Expanded(
                child: ButtonBasic(
                  title: '선택 안함',
                  titleColorBg: colorGreen900,
                  colorBg: colorWhite,
                  borderColor: colorGreen900,
                  onTap: () {
                    tempSelectedDistricts.value = []; // 모든 선택 해제
                  },
                ),
              ),
              Gaps.h16,
              Expanded(
                child: ButtonBasic(
                  title: '확인',
                  titleColorBg: colorWhite,
                  colorBg: colorGreen800,
                  onTap: () {
                    // 선택된 구를 최종적으로 vnSelectedFilterList에 반영하고 닫기
                    vnSelectedFilterList.value =
                        List.from(tempSelectedDistricts.value);
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Gaps.h10,
            ],
          ),
          Gaps.v16,
        ],
      ),
    );
  }
}
