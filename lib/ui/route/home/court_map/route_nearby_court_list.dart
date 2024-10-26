import 'package:flutter/material.dart';

import '../../../../const/value/colors.dart';
import '../../../../const/value/gaps.dart';
import '../../../../const/value/text_style.dart';
import 'neartby_courts_map.dart';

class RouteNearbyCourtList extends StatelessWidget {
  const RouteNearbyCourtList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("근처 코트"),
      ),

      body: Column(children: [

        Row(
          children: [
            Text(
              'NEARBY 5KM',
              style: TS.s14w700(colorGray900),
            ),
          ],
        ),

        Gaps.v10,
        // `NearbyCourtsMap`을 Expanded로 감싸기
        const SizedBox(
          height: 300, // 원하는 높이로 설정 가능
          child: NearbyCourtsMap(),
        ),

      ],),
    );
  }
}
