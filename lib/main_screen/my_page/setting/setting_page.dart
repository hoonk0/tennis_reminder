import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tennisreminder/const/color.dart';
import 'package:tennisreminder/const/text_style.dart';
import 'package:tennisreminder/main_screen/my_page/setting/setting_detail/court_manager/setting_manager_court.dart';

import 'package:tennisreminder/main_screen/my_page/setting/setting_detail/notice/setting_notice.dart';
import 'package:tennisreminder/main_screen/my_page/setting/setting_detail/setting_contact_manager.dart';

import '../../../start/login_screen.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff719a93),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: Color(0xff719a93), // 주변색을 초록색으로 설정
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'LET\'S VIBE',
                        style: GoogleFonts.anton(
                          textStyle: TS.s24w500(colorWhite),
                        ), // 텍스트 색상을 흰색으로 설정
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Container(
              color: const Color(0xfff2efef),
              height: 20,
            ),


            Row(
              children: [
                Expanded(
                  child: Container(
                    color: Color(0xfff2efef),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Notice',
                            style: GoogleFonts.anton(
                              textStyle: TS.s24w500(colorGreen900),
                            ), // 텍스트 색상을 흰색으로 설정
                          ),
                        ),
                      ],
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
                      color: const Color(0xffe8e8e8),
                      child: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          '공지사항',
                          style: TS.s16w500(colorGreen900),
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
                      color: const Color(0xfff2efef),
                      child: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          '고객센터',
                          style: TS.s16w500(colorGreen900),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              color: const Color(0xffe8e8e8),
              height: 20,
            ),

            Row(
              children: [
                Expanded(
                  child: Container(
                    color: const Color(0xffe8e8e8),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Account',
                            style: GoogleFonts.anton(
                              textStyle: TS.s24w500(colorGreen900),
                            ), // 텍스트 색상을 흰색으로 설정
                          ),
                        ),
                      ],
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
                      color: const Color(0xfff2efef),
                      child: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          '개인정보',
                          style: TS.s16w500(colorGreen900),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            GestureDetector(
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
                                color: Color(0xff333333),
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              '지금 로그아웃하시겠어요?',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff7b796f),
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
                                    foregroundColor: colorWhite, backgroundColor: colorGreen900, // 텍스트 색상
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
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      color: const Color(0xffe8e8e8),
                      child: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          '로그아웃',
                          style: TS.s16w500(colorGreen900),
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
                  MaterialPageRoute(builder: (context) => const SettingManagerCourt()),
                );
              },
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      color: const Color(0xfff2efef),
                      child: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Text(
                              '관리자 페이지',
                              style: TS.s16w500(colorGreen900),
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
                color: const Color(0xfff2efef),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
