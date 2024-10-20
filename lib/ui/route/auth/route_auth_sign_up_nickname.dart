import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tennisreminder/ui/route/auth/route_auth_profile.dart';
import '../../../const/enum/enums.dart';
import '../../../const/service/utils/utils.dart';
import '../../../const/value/colors.dart';
import '../../../const/value/gaps.dart';
import '../../../const/value/keys.dart';
import '../../../const/value/text_style.dart';
import '../../component/button_basic.dart';
import '../../component/textfield_border.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initNickname();
  }

  Future<void> initNickname() async {
    if (widget.nickname != null) {
      checkNickname(true);
    }
  }

  Future<void> checkNickname(bool isInit) async {
    final nickname = tecNickname.text;
    final userQs = await FirebaseFirestore.instance.collection(keyUser).where(keyNickname, isEqualTo: nickname).get();
    if (userQs.docs.isEmpty) {
      Utils.toast(desc: '닉네임 중복 확인이 완료되었습니다.');
      if (isInit) {
        tecNickname.text = widget.nickname!;
      }
      vnSignUpButtonEnabled.value = true;
    } else {
      vnSignUpButtonEnabled.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('닉네임'),
        ),
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
                        const Text(
                          '닉네임',
                          style: TS.s14w500(colorGray900),
                        ),
                        Gaps.v10,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: ValueListenableBuilder(
                                valueListenable: tecNickname,
                                builder: (context, value, child) {
                                  debugPrint("리빌드 ${tecNickname.text.isEmpty}");
                                  return TextFieldBorder(
                                    controller: tecNickname,
                                    hintText: '닉네임 입력',
                                    keyboardType: TextInputType.text,
                                    onChanged: (value) {},
                                    errorText: tecNickname.text.isNotEmpty ? null : '닉네임을 입력해주세요',
                                  );
                                },
                              ),
                            ),
                            Gaps.h8,
                            Expanded(
                              child: ValueListenableBuilder(
                                valueListenable: tecNickname,
                                builder: (context, tec, child) {
                                  return ButtonBasic(
                                    title: '중복확인',
                                    colorBg: tecNickname.text.isNotEmpty ? colorGreen600 : colorGray200,
                                    onTap: () async {
                                      if (tecNickname.text.isEmpty) {
                                        Utils.toast(desc: '닉네임을 입력해주세요.');
                                        return;
                                      }
                                      checkNickname(false);
                                    },
                                  );
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
                      title: '다음',
                      titleColorBg: isButtonEnabled ? colorWhite : colorGray500,
                      colorBg: isButtonEnabled ? colorGreen600 : colorGray200,
                      onTap: isButtonEnabled
                          ? () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => RouteAuthProfile(
                                        uid: widget.uid,
                                        email: widget.email,
                                        phoneNumber: widget.phoneNumber,
                                        nickname: tecNickname.text,
                                        loginType: widget.loginType,
                                      )));
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
