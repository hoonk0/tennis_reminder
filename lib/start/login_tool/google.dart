import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UtilsLogin {
  static Future<UserCredential?> onGoogleTap() async {
    GoogleSignInAccount? account;

    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      debugPrint("googleSignIn ${googleSignIn.serverClientId} ${googleSignIn.clientId}");
      account = await googleSignIn.signIn();

      if (account != null) {
        GoogleSignInAuthentication authentication = await account.authentication;

        OAuthCredential googleCredential = GoogleAuthProvider.credential(
          idToken: authentication.idToken,
          accessToken: authentication.accessToken,
        );

        final credential = await FirebaseAuth.instance.signInWithCredential(googleCredential);

        debugPrint('로그인 이메일 ${credential.user!.email}');

        if (credential.user != null) {
          // 로그인 성공 시
          Fluttertoast.showToast(msg: '  Google auth success  ');
          return credential;
        } else {
          return null;
        }
      } else {}
    } on FirebaseAuthException catch (e, s) {
      Fluttertoast.showToast(msg: ' 구글 인증 실패 ');
      if (e.code == 'invalid-email') {
        Fluttertoast.showToast(msg: '  Google auth success  ');
      } else if (e.code == 'user-disabled') {
        Fluttertoast.showToast(msg: '  user-disable  ');
      } else if ((e.code == 'user-not-found') || (e.code == 'wrong-password')) {
        Fluttertoast.showToast(msg: '  ser-not-found  ');
      } else if (e.code == 'too-many-requests') {
        Fluttertoast.showToast(msg: '  too-many-requests  ');
      } else {}
    }
  }
}
