

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tennisreminder/home_screen/drawmenu/search_court/court_favorite.dart';
import 'package:tennisreminder/home_screen/drawmenu/search_court/court_search.dart';
import 'package:tennisreminder/home_screen/drawmenu/setting/list_setting_user.dart';
import 'package:tennisreminder/home_screen/home_screen.dart';

import '../const/color.dart';

class MainScreen extends StatefulWidget {
  final int selectedIndex; // 선택된 인덱스를 저장하기 위한 변수

  const MainScreen({required this.selectedIndex});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // initState에서 선택된 인덱스를 설정
    _selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      // _selectedIndex가 0이 아닌 경우 앱바를 숨김
      body: _selectedIndex == 0
          ? const HomeScreen()
          : (_selectedIndex == 1 ? const CourtSearch() :
      (_selectedIndex == 2 ? CourtFavorite() :
      ListSettingUser()
      )
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: 'SEARCH',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_rounded),
            label: 'LIKE',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: 'MY',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: const Color(0xffd2c6c0),
        selectedItemColor: colorGreen900,
        onTap: _onItemTapped,
      ),

//      endDrawer: DrawerMenu(),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // 선택된 인덱스 업데이트
    });
  }
}
