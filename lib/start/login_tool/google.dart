import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main_screen/mainscreen.dart';
import '../../model/model_member.dart';
import '../../service/utils/doggaebiutils.dart';

class UtilsLogin {
  static void onGoogleTap(BuildContext context) async {
    GoogleSignInAccount? account;
    DoggaebiUtils.toast('  로그인 시도중입니다  \n  잠시만 기다려 주세요  ');

    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      account = await googleSignIn.signIn();
      DoggaebiUtils.toast('  구글 정보를 인증중 입니다  ');

      if (account != null) {
        GoogleSignInAuthentication authentication = await account.authentication;
        OAuthCredential googleCredential = GoogleAuthProvider.credential(
          idToken: authentication.idToken,
          accessToken: authentication.accessToken,
        );
        FirebaseAuth.instance.signInWithCredential(googleCredential).then((credential) async {
          debugPrint('로그인 이메일 ${credential.user!.email}');

          if (credential.user != null) {
            // 로그인 성공 시
            DoggaebiUtils.toast('  구글 로그인에 성공하였습니다  ');
            DoggaebiUtils.log.i('구글 로그인 성공\n사용자: ${FirebaseAuth.instance.currentUser}');

            // Firestore에 사용자 정보 저장
            final user = credential.user!;
            final userId = user.uid;
            final userDs = await FirebaseFirestore.instance.collection('member').doc(userId).get();

            if (!userDs.exists) {
              // ModelMember 생성 및 Firestore에 저장
              ModelMember newUser = ModelMember(
                id: userId,
                memberid: user.email!,
                pw: '',
                name: user.displayName ?? '',
                phone: '',
                location: '',
                email: user.email!,
              );
              await _saveUserToFirestore(newUser);
            }

            // SharedPreferences에 UID 저장
            final pref = await SharedPreferences.getInstance();
            pref.setString('uid', userId);

            // MainScreen으로 이동
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainScreen(selectedIndex: 0)),
            );
          } else {
            // 로그인 실패시
            DoggaebiUtils.toast('  로그인에 실패하였습니다  \n  다시 시도해주세요  ');
          }
        });
      }
    } catch (e, s) {
      DoggaebiUtils.toast('  구글 로그인에 실패하였습니다  \n  다시 시도해주세요  ');
      DoggaebiUtils.log.f('구글 로그인 실패\n$e\n$s');
    }
  }

  static Future<void> _saveUserToFirestore(ModelMember user) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('member').doc(user.id).set(user.toJson());
  }
}
