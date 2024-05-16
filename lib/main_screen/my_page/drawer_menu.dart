
import 'package:flutter/material.dart';
import 'package:tennisreminder/const/color.dart';
import 'package:tennisreminder/main_screen/my_page/setting/list_setting_user.dart';
import 'package:tennisreminder/main_screen/my_page/setting/setting_detail/court_manager/setting_manager_court.dart';



import '../home/user_home.dart';
import 'often_court/often_court.dart';

class DrawerMenu extends StatefulWidget {


  const DrawerMenu({super.key});

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 120, // 화면 전체 너비에서 75 픽셀을 뺀 크기
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 250, // DrawerHeader의 높이를 250으로 설정
              child: Center(
                child: DrawerHeader(
                  decoration: BoxDecoration(
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 30, // 프로필 사진 크기
                        backgroundColor: colorGreen900, // 원의 배경색
                        // 프로필 이미지가 있다면 backgroundImage 속성을 사용하세요.
                        // backgroundImage: AssetImage('assets/profile_image.jpg'),
                        child: Icon(
                          Icons.person, // 기본 프로필 아이콘
                          size: 48, // 아이콘 크기
                          color: colorWhite, // 아이콘 색상
                        ),
                      ),
                      SizedBox(height: 8), // 프로필 사진과 이름 사이의 간격 조절
                      Text(
                        'name', // 여기에 사용자 이름을 넣으세요.
                        style: TextStyle(
                          color: Color(0xff333333),
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '환영합니다',
                        style: TextStyle(
                          color: Color(0xff87857a),
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            ListTile(
              title: const Text('코트 검색'),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserHome()),
                );
              },
            ),

            ListTile(
              title: const Text('즐겨 찾는 코트'),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OftenCourt()),
                );
              },
            ),

            ListTile(
              title: const Text('설정'),
              onTap: (){

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ListSettingUser()),
                );
              },
            ),

/*            ListTile(
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
*/

            ListTile(
              title: const Text('관리자 페이지'),
              onTap: (){

                // isAdmin이 true인 경우에만 이동

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingManagerCourt()),
                  );

              },

            ),
          ],
        ),
      ),
    );
  }
}
