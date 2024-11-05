import 'package:flutter/material.dart';
import '../../const/enum/enums.dart';
import '../../const/value/colors.dart';
import '../../const/value/gaps.dart';
import '../../const/value/text_style.dart';
import '../component/button_basic.dart';
import '../component/custom_checkbox_container.dart';

class BottomSheetParkingFilter extends StatelessWidget {
  final ValueNotifier<bool?> vnSelectedFilter;

  const BottomSheetParkingFilter({
    super.key,
    required this.vnSelectedFilter,
  });

  @override
  Widget build(BuildContext context) {
    // 임시 선택 상태를 저장할 ValueNotifier
    ValueNotifier<bool?> tempSelected = ValueNotifier<bool?>(vnSelectedFilter.value);

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
          const Text('주차장 필터', style: TS.s18w600(Color(0xff222222))),
          Gaps.v20,

          /// 필터
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: ValueListenableBuilder<bool?>(
                  valueListenable: tempSelected,
                  builder: (context, selected, child) {
                    return Column(
                      children: [
                        CustomCheckboxContainer(
                          title: '주차장 있음',
                          isSelected: selected == true,
                          onTap: () {
                            tempSelected.value = true; // 주차장 있음 선택
                          },
                        ),
                        CustomCheckboxContainer(
                          title: '주차장 없음',
                          isSelected: selected == false,
                          onTap: () {
                            tempSelected.value = false; // 주차장 없음 선택
                          },
                        ),
                      ],
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
                    tempSelected.value = null; // 모든 선택 해제
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
                    // 선택된 주차장 유무를 최종적으로 vnSelectedFilter에 반영하고 닫기
                    vnSelectedFilter.value = tempSelected.value;
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
