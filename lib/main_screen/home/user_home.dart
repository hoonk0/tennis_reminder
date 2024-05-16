import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../const/color.dart';
import '../../const/text_style.dart';
import '../../model/model_court.dart';
import '../my_page/search_court/court_information.dart';
import '../my_page/search_court/court_search.dart';


class UserHome extends StatefulWidget {

  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {

  late List<ModelCourt> modelCourts;


  @override
  void initState() {
    super.initState();
    modelCourts = []; // 데이터를 담을 리스트 초기화
    _fetchCourtData(); // Firestore에서 데이터 가져오기

  }

  Future<void> _fetchCourtData() async {
    final courtSnapshot = await FirebaseFirestore.instance.collection('court').get();
    final List<ModelCourt> fetchedOuterModels = courtSnapshot.docs.map((doc) {
      final data = doc.data();
      return ModelCourt.fromJson(data);
    }).toList();

    setState(() {
      modelCourts = fetchedOuterModels;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('COURT VIBE', style: TS.s20w700(colorGreen900)),
      ),
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '우리동네 코트 찾기',
                  style: TS.s14w600(colorGreen900),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CourtSearch()),
                    );
                  },
                  icon: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ),

          const SizedBox(height: 50),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '원하는 코트 찾아보기',
                  style: TS.s14w600(colorGreen900),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CourtSearch()),
                    );
                  },
                  icon: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10), // 텍스트와 그리드 사이의 간격
          SizedBox(
            height: 150, // 그리드의 높이 조정
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, // 행의 수
                childAspectRatio: 1, // 항목의 가로 세로 비율
              ),
              itemCount: modelCourts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    final watchModelCourt = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CourtInformation(modelCourt: modelCourts[index])),
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
                      borderRadius: BorderRadius.circular(8)
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: modelCourts[index].imagePath.isNotEmpty
                              ? Image.file(
                            File(modelCourts[index].imagePath),
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
        ],
      ),

/*


      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.search_rounded),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite_border_rounded),
            label: 'Like',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: 'My',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: const Color(0xffd2c6c0),
        selectedItemColor: colorGreen900,
        onTap: _onItemTapped,
      ),

 */

      //endDrawer: DrawerMenu(),
    );
  }
}

/*

            ValueListenableBuilder(
              valueListenable: userNotifier,
              builder: (context, userMe, child) => Column(
                children: [
                  Text('My email : ${userMe!.email}', style: TS.s15w500(colorGray900)),
                  if (userMe.isAdmin) const Text('admin만 보임', style: TS.s15w500(colorGray900)),
                ],
              ),
            ),

 */
