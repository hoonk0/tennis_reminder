import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao_user;
import 'package:sizer/sizer.dart';
import 'package:tennisreminder/main_screen/home/user_home.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tennisreminder/main_screen/mainscreen.dart';
import 'package:tennisreminder/model/model_member.dart';
import 'package:tennisreminder/service/provider/providers.dart';
import '../const/color.dart';
import '../const/gaps.dart';
import '../const/text_style.dart';
import 'login/new_member.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

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
      Navigator.push(context, MaterialPageRoute(builder: (context) => const MainScreen(selectedIndex: 0)));
    });
*/
//디버깅용 로그인 화면 스킵 코드
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

  Future<void> signInWithKakao() async {
    if (await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공');
        await _handleKakaoLogin();
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공');
          await _handleKakaoLogin();
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {
        await UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공');
        await _handleKakaoLogin();
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  }

  Future<void> _handleKakaoLogin() async {
    // 사용자 정보 가져오기
    User user = await UserApi.instance.me();
    String email = user.kakaoAccount?.email ?? '';
    String nickname = user.kakaoAccount?.profile?.nickname ?? '';

    // ModelMember 생성 및 Firestore에 저장
    ModelMember newUser = ModelMember(
      id: user.id.toString(),
      memberid: email,
      pw: '', // 카카오톡 로그인에서는 pw 사용하지 않음
      name: nickname,
      phone: '',
      location: '',
      email: email,
    );
    await _saveUserToFirestore(newUser);
    userNotifier.value = newUser;

    // 화면 전환
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => MainScreen(selectedIndex: 0),
      ),
    );
  }

  Future<void> _saveUserToFirestore(ModelMember user) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('member').doc(user.id).set(user.toJson());
  }

/*
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

*/
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: colorWhite,
        body: Column(
          children: [
            Gaps.v20,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    Image.asset(
                      fit: BoxFit.fill,
                      'assets/home/logo_main.png',
                      width: 60.w,
                    ),
                    Container(
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
                              obscureText: true,
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
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainScreen(selectedIndex: 0)),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      text: '로그인 없이 둘러보기',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: colorGreen900,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Gaps.v20,

            GestureDetector(
              onTap: () {
                //signInWithGoogle();
              },
              child: Column(
                children: [
                  Image.asset(
                    'assets/home/google_login.png',
                    fit: BoxFit.fill,
                    height: 12.w,
                    width: 50.w,
                  ),
                ],
              ),
            ),

            Gaps.v10,

            GestureDetector(
              onTap: () {
                signInWithKakao();
              },
              child: Column(
                children: [
                  Image.asset(
                    'assets/home/kakao_login_large_wide.png',
                    fit: BoxFit.fill,
                    height: 12.w,
                    width: 50.w,
                  ),
                ],
              ),
            ),


            Container(
              height: 20.w,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NewMember(),
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
                  ],
                ),
              ),
            ),

            Container(
              height: 20.w,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const MainScreen(
                                    selectedIndex: 0,
                                  )));
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
