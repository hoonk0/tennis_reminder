import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tennisreminder/ui/route/auth/route_auth_profile(not use).dart';
import '../../../const/enum/enums.dart';
import '../../../const/model/model_user.dart';
import '../../../const/service/utils/utils.dart';
import '../../../const/static/global.dart';
import '../../../const/value/colors.dart';
import '../../../const/value/gaps.dart';
import '../../../const/value/keys.dart';
import '../../../const/value/text_style.dart';
import '../../component/button_basic.dart';
import '../../component/textfield_border.dart';
import '../route_splash.dart';

class RouteAuthSignUpNickname extends StatefulWidget {
  final String email;
  final String phoneNumber;
  final String? nickname;
  final String uid;
  final EnumLoginType loginType;

  const RouteAuthSignUpNickname({
    super.key,
    required this.email,
    required this.phoneNumber,
    this.nickname,
    required this.uid,
    required this.loginType,
  });

  @override
  State<RouteAuthSignUpNickname> createState() => _RouteAuthSignUpNicknameState();
}

class _RouteAuthSignUpNicknameState extends State<RouteAuthSignUpNickname> {
  final TextEditingController tecNickname = TextEditingController();
  final ValueNotifier<bool> vnSignUpButtonEnabled = ValueNotifier(false);
  bool isCheckingNickname = false;

  @override
  void initState() {
    super.initState();
    initNickname();
  }

  Future<void> initNickname() async {
    if (widget.nickname?.isNotEmpty ?? false) {
      tecNickname.text = widget.nickname!;
      await checkNickname(true); // 초깃값으로 중복 확인 호출
    }
  }

  Future<void> checkNickname(bool isInit) async {
    final nickname = tecNickname.text.trim();

    if (nickname.isEmpty) {
      Utils.toast(desc: '닉네임을 입력해주세요.');
      return;
    }

    try {
      final userQs = await FirebaseFirestore.instance
          .collection(keyUser)
          .where(keyNickname, isEqualTo: nickname)
          .get();

      if (userQs.docs.isEmpty) {
        Utils.toast(desc: '닉네임 중복 확인이 완료되었습니다.');
        vnSignUpButtonEnabled.value = true;
      } else {
        vnSignUpButtonEnabled.value = false;
        Utils.toast(desc: '닉네임이 이미 사용 중입니다.');
      }
    } catch (e) {
      Utils.toast(desc: '오류가 발생했습니다: $e');
    } finally {
      isCheckingNickname = false; // 중복 확인이 끝났음을 표시
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('닉네임')),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gaps.v28,
                        const Text('닉네임', style: TS.s14w500(colorGray900)),
                        Gaps.v10,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: TextFieldBorder(
                                controller: tecNickname,
                                hintText: '닉네임 입력',
                                keyboardType: TextInputType.text,
                                onChanged: (value) {
                                  final trimmedValue = value.trim();
                                  vnSignUpButtonEnabled.value =
                                      trimmedValue.isNotEmpty && !isCheckingNickname;
                                },
                                errorText: tecNickname.text.trim().isNotEmpty
                                    ? null
                                    : '닉네임을 입력해주세요',
                              ),
                            ),
                            Gaps.h8,
                            Expanded(
                              child: ButtonBasic(
                                title: '중복확인',
                                colorBg: tecNickname.text.isNotEmpty
                                    ? colorGreen900
                                    : colorGray200,
                                onTap: () async {
                                  if (isCheckingNickname) return;
                                  if (tecNickname.text.trim().isEmpty) {
                                    Utils.toast(desc: '닉네임을 입력해주세요.');
                                    return;
                                  }
                                  isCheckingNickname = true;
                                  await checkNickname(false);
                                },
                              ),
                            ),
                          ],
                        ),
                        Gaps.v10,
                      ],
                    ),
                  ),
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: vnSignUpButtonEnabled,
                  builder: (context, isButtonEnabled, child) {
                    return ButtonBasic(
                      title: '가입 완료',
                      titleColorBg: isButtonEnabled ? colorWhite : colorGray500,
                      colorBg: isButtonEnabled ? colorGreen900 : colorGray200,
                      onTap: isButtonEnabled
                          ? () async {
                        final modelUser = ModelUser(
                          uid: widget.uid,
                          nickname: tecNickname.text.trim(),
                          phoneNumber: widget.phoneNumber,
                          email: widget.email,
                          loginType: widget.loginType,
                        );
                        pref?.setString(keyUid, modelUser.uid);
                        await FirebaseFirestore.instance
                            .collection(keyUser)
                            .doc(modelUser.uid)
                            .set(modelUser.toJson());
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const RouteSplash(),
                          ),
                              (route) => false,
                        );
                      }
                          : null,
                    );
                  },
                ),
                Gaps.v16,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
