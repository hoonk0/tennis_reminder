import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tennisreminder/ui/component/custom_divider.dart';
import 'package:tennisreminder/ui/route/alarm/route_court_alarm.dart';
import 'package:tennisreminder/ui/route/favorite/court_favorite.dart';
import 'package:tennisreminder/ui/route/profile/notice/route_setting_notice.dart';
import '../../../const/value/colors.dart';
import '../../../const/value/gaps.dart';
import '../../../const/value/keys.dart';
import '../../../const/value/text_style.dart';
import '../../../service/utils/utils.dart';
import '../../../static/global.dart';
import '../../component/custom_container_profile_list.dart';
import '../../component/button_basic.dart';
import '../profile/court_manager/setting_manager_court.dart';
import '../profile/route_profile_edit_my_info_sns.dart';
import '../profile/route_profile_privacy_policy.dart';
import '../route_splash.dart';

class TabProfile extends StatelessWidget {
  const TabProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Gaps.v16,
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('홍길동', style: TS.s16w600(colorGray900)),
                        Text('구글 로그인 계정', style: TS.s14w500(colorGray700)),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RouteProfileEditMyInfoSns(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorGreen900,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8.0),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/icons/pencil.png',
                            fit: BoxFit.fitWidth,
                            height: 16,
                          ),
                          Gaps.h4,
                          Text('수정', style: TS.s14w600(colorWhite)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              CustomDivider(
                margin: EdgeInsets.symmetric(vertical: 10),
                height: 3,
              ),
              _buildProfileOptions(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOptions(BuildContext context) {
    return Column(
      children: [
        CustomContainerProfileList(
          title: "선호 코트",
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => RouteCourtFavorite()),
            );
          },
        ),
        CustomContainerProfileList(
          title: "알람 코트",
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => RouteCourtAlarm()),
            );
          },
        ),
        CustomContainerProfileList(
          title: "공지사항",
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => RouteSettingNotice()),
            );
          },
        ),

        CustomDivider(margin: EdgeInsets.symmetric(vertical: 10), height: 1),

        CustomContainerProfileList(
          title: "개인정보처리방침 및 이용약관",
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => RouteProfilePrivate()),
            );
          },
        ),

        CustomContainerProfileList(
          title: "로그아웃",
          onTap: () {
            showLogoutModalBottomSheet(context);
          },
        ),
        CustomContainerProfileList(
          title: "회원탈퇴",
          onTap: () {
            showMemberOutModalBottomSheet(context);
          },
        ),
        // 관리자 화면: userGrade가 'admin'일 때만 표시

        CustomContainerProfileList(
          title: "관리자화면",
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SettingManagerCourt(),
              ),
            );
          },
        )

        ///질문 유저등급에 따라 보이게 하기
/*        ValueListenableBuilder(
          valueListenable: Global.userNotifier,
          builder: (context, user, child) {
            debugPrint('유저등급: ${user?.userGrade}'); // 로그로 확인

            // user가 null인 경우 처리
            if (user == null) {
              return SizedBox(); // 데이터가 없으면 빈 위젯 반환
            }

            if (user.userGrade == 'admin') {
              return CustomContainerProfileList(
                title: "관리자화면",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SettingManagerCourt(),
                    ),
                  );
                },
              );
            } else {
              return SizedBox(); // 관리자 등급이 아니면 빈 위젯 반환
            }
          },
        ),*/
      ],
    );
  }

  void showLogoutModalBottomSheet(BuildContext contextMain) {
    showModalBottomSheet(
      context: contextMain,
      builder: (BuildContext context) {
        return _buildLogoutModal(context);
      },
    );
  }

  Widget _buildLogoutModal(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 44, height: 4),
          const Text(
            '정말로 로그아웃을 하시겠어요?',
            style: TS.s18w600(colorGray900),
          ),
          Gaps.v46,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ButtonBasic(
                  title: '로그아웃',
                  colorBg: colorRed,
                  titleColorBg: colorGray500,
                  onTap: () async {
                    Navigator.of(context).pop();
                    Utils.toast(desc: '정상적으로 로그아웃 되었습니다.');
                    final pref = await SharedPreferences.getInstance();
                    pref.remove('uid');
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const RouteSplash()),
                      (route) => false,
                    );
                  },
                ),
              ),
              Gaps.h15,
              Expanded(
                child: ButtonBasic(
                  title: '다음에',
                  colorBg: colorGreen600,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showMemberOutModalBottomSheet(BuildContext contextMain) {
    showModalBottomSheet(
      context: contextMain,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
      ),
      builder: (BuildContext context) {
        return _buildMemberOutModal(context);
      },
    );
  }

  Widget _buildMemberOutModal(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "정말로 회원탈퇴를 하시겠어요?",
            style: TS.s18w600(colorGray900),
            textAlign: TextAlign.center,
          ),
          const Text(
            "탈퇴 시 모든 정보를 되돌릴 수 없습니다.",
            style: TS.s14w500(colorGray700),
          ),
          Gaps.v46,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ButtonBasic(
                  title: '회원 탈퇴',
                  colorBg: colorBlack,
                  titleColorBg: colorGray500,
                  onTap: () async {
                    FirebaseFirestore.instance
                        .collection(keyUser)
                        .doc(Global.userNotifier.value!.uid)
                        .delete();

                    final pref = await SharedPreferences.getInstance();
                    pref.remove('uid');

                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => RouteSplash(),
                      ),
                      (route) => false,
                    );
                    Utils.toast(desc: '정상적으로 탈퇴되었습니다.');
                  },
                ),
              ),
              Gaps.h15,
              Expanded(
                child: ButtonBasic(
                  title: '다음에',
                  colorBg: colorGreen600,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
