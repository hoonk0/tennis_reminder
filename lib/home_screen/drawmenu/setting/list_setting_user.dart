import 'package:flutter/material.dart';
import 'package:tennisreminder/home_screen/drawmenu/setting/setting_detail/court_manager/setting_manager_court.dart';
import 'package:tennisreminder/home_screen/drawmenu/setting/setting_detail/setting_contact_manager.dart';
import 'package:tennisreminder/home_screen/drawmenu/setting/setting_detail/setting_my_page.dart';
import 'package:tennisreminder/home_screen/drawmenu/setting/setting_detail/setting_donation.dart';
import 'package:tennisreminder/home_screen/drawmenu/setting/setting_detail/setting_notice.dart';

import '../../../const/color.dart';
import '../../../start/login_screen.dart';

class ListSettingUser extends StatelessWidget {
  const ListSettingUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('setting'),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('개인정보'),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingMyPage()),
              );
            },
          ),

          ListTile(
            title: const Text('공지사항'),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingNotice()),
              );
            },
          ),

          ListTile(
            title: const Text('고객센터'),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContactManager()),
              );
            },
          ),

          ListTile(
            title: const Text('후원'),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingDonation()),
              );
            },
          ),

          ListTile(
            title: const Text('로그아웃'),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 200,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            '로그아웃 하시겠습니까?',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff333333)
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            '지금 로그아웃하시겠어요?',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff7b796f)
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: colorWhite, backgroundColor: colorGray300, // 텍스트 색상
                                  textStyle: const TextStyle(fontSize: 16), // 텍스트 스타일
                                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 60), // 버튼 내부 패딩
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8), // 버튼의 모서리를 둥글게 만듦
                                  ),
                                ),
                                child: const Text('취소'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                                  ); // 바텀 시트 닫기
                                  // 로그아웃 처리
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: const Color(0xffffffff), backgroundColor: colorGreen900, // 텍스트 색상
                                  textStyle: const TextStyle(fontSize: 16), // 텍스트 스타일
                                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 60), // 버튼 내부 패딩
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8), // 버튼의 모서리를 둥글게 만듦
                                  ),
                                ),
                                child: const Text('로그아웃'),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          ListTile(
            title: const Text('관리자 페이지'),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingManagerCourt()),
              );
            },
          ),


        ],
      ),
    );
  }
}
