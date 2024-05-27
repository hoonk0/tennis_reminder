import 'package:flutter/material.dart';
import 'package:tennisreminder/const/color.dart';
import 'package:tennisreminder/const/text_style.dart';
import 'package:tennisreminder/main_screen/my_page/setting/setting_detail/court_manager/setting_manager_court.dart';
import 'dart:math' as math;

import 'package:tennisreminder/main_screen/my_page/setting/setting_detail/notice/setting_notice.dart';
import 'package:tennisreminder/main_screen/my_page/setting/setting_detail/setting_contact_manager.dart';
import '../../../start/login_screen.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff719a93),
        ),
        body: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          color: Color(0xff719a93),
                          height: 80,
                        ),
                        Container(
                          color: Color(0xfff2efef),
                          height: 50,
                        ),
                      ],
                    ),
                    Positioned(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white, // 배경색 흰색
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(0xff719a93),
                            width: 4,
                          ),
                        ),
                        child: Icon(
                          Icons.person,
                          size: 80,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Color(0xfff2efef),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          children: [
                            Text(
                              'Notification',
                              style: TS.s24w700(colorGreen900),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingNotice()),
                  );
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Color(0xffe8e8e8),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            '공지사항',
                            style: TS.s20w500(colorGreen900),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ContactManager()),
                  );
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Color(0xfff2efef),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            '고객센터',
                            style: TS.s20w500(colorGreen900),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Color(0xffe8e8e8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          children: [
                            Text(
                              '\n Account',
                              style: TS.s24w700(colorGreen900),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              GestureDetector(

                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Color(0xfff2efef),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            '개인정보',
                            style: TS.s20w500(colorGreen900),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Color(0xffe8e8e8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          '로그아웃',
                          style: TS.s20w500(colorGreen900),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingManagerCourt()),
                  );
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Color(0xfff2efef),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              Text(
                                '관리자 페이지',
                                style: TS.s20w500(colorGreen900),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Container(
                  color: Color(0xfff2efef),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
