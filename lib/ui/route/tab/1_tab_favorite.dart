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
              onTap: () {
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
            Text('성동구 코트'),

/*            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '주변 코트 검색하기',
                  style: TS.s14w700(colorGray900),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CourtSearch()),
                    );
                  },
                  icon: const Icon(Icons.arrow_forward),
                  color: colorGray900,
                ),
              ],
            ),
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
                    ///
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                modelCourts[index].name,
                                style: const TS.s12w600(colorBlack),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),*/
          ],
        ),
      )),
    );
  }
}
