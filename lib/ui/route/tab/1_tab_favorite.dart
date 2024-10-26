import 'package:flutter/material.dart';
import 'package:tennisreminder/ui/route/home/court_map/route_nearby_court_list.dart';

import '../../../const/value/colors.dart';
import '../../../const/value/gaps.dart';
import '../../../const/value/text_style.dart';
import '../favorite/court_favorite.dart';
import '../home/court_map/neartby_courts_map.dart';

class TabFavorite extends StatelessWidget {
  const TabFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
                    children: [

            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => RouteNearbyCourtList()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '주변 코트 검색하기',
                    style: TS.s14w700(colorGray900),
                  ),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),



            Text('하드코트'),
            Text('성동구 코트')],
                  ),
          )),
    );
  }
}
