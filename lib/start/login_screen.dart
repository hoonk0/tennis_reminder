import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tennisreminder/home_screen/home_screen.dart';
import 'package:tennisreminder/login/new_member.dart';
import 'package:tennisreminder/model/model_member.dart';
import 'package:tennisreminder/service/provider/providers.dart';
import '../const/color.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController tecId = TextEditingController();
  final TextEditingController tecPw = TextEditingController();
  bool _isInputValid = false;

  @override
  void initState() {
    super.initState();
    tecId.addListener(_validateInput);
    tecPw.addListener(_validateInput);
    /*
    WidgetsBinding.instance.endOfFrame.then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const SelectOption()));
    });
     */
  }

  @override
  void dispose() {
    tecId.dispose();
    tecPw.dispose();
    super.dispose();
  }

  void _validateInput() {
    setState(() {
      _isInputValid = tecId.text.isNotEmpty && tecPw.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 180,
                    height: 222,
                    child: Container(
                      margin: const EdgeInsets.only(left: 32, top: 96),
                      child: const Text(
                        '테니스 \n 알리미',
                        style: TextStyle(
                          color: colorGreen900,
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 250,
                    //테니스 사진
                  ),
                  SizedBox(
                    width: 350,
                    height: 200,
                    child: Container(
                      margin: const EdgeInsets.only(left: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              'ID',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: colorGreen900,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: TextField(
                              controller: tecId,
                              style: const TextStyle(
                                fontSize: 16,
                                color: colorGreen900,
                              ),
                              decoration: const InputDecoration(
                                hintText: '아이디 입력하세요',
                                hintStyle: TextStyle(
                                  color: colorGreen900,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              'PW',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: colorGreen900,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: TextField(
                              controller: tecPw,
                              style: const TextStyle(
                                fontSize: 16,
                                color: colorGreen900,
                              ),
                              decoration: const InputDecoration(
                                hintText: '비밀번호를 입력하세요',
                                hintStyle: TextStyle(
                                  color: colorGreen900,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 160,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewMember(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorGreen900,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text(
                    '회원가입',
                    style: TextStyle(color: colorWhite),
                  ),
                ),
              ),
              SizedBox(
                width: 160,
                child: ElevatedButton(
                  onPressed: () {
                    //나중에 구글 연동 추가
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorGreen900,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text(
                    '구글',
                    style: TextStyle(
                      color: colorWhite,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () async {
                // id가 비어있는지, pw 비어있는지 확인
                // id가 있는 여부 확인
                // 없으면 없다고 메세지
                // 있으면 비밀번호 확인
                // 비밀번호 틀리면 틀렸다고 메세지
                // 맞으면 로그인
                final id = tecId.text;
                final pw = tecPw.text;
                if (id.isEmpty || pw.isEmpty) {
                  Fluttertoast.showToast(msg: '아이디와 비밀번호를 입력하세요.');
                  return;
                }
                final idQs = await FirebaseFirestore.instance.collection('member').where('memberid', isEqualTo: id).get();
                if (idQs.docs.isEmpty) {
                  Fluttertoast.showToast(msg: '일치하는 아이디가 없습니다.');
                  return;
                }
                final targetModelUser = ModelMember.fromJson(idQs.docs.first.data()); // 내 정보
                if (pw != targetModelUser.pw) {
                  Fluttertoast.showToast(msg: '비밀번호가 일치하지 않습니다.');
                  return;
                }
                userNotifier.value = targetModelUser;
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
                // 여기서 로그인
              }, //_isInputValid ? _login : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isInputValid ? colorGreen900 : colorGray300,
                fixedSize: const Size(360, 56),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
              ),
              child: const Text(
                '로그인',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: colorWhite,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
