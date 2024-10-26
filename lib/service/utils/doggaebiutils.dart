import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class DoggaebiUtils {
  /*스넥 매세지*/
  static void toast(
      String text, {
        ToastGravity toastGravity = ToastGravity.CENTER,
        Toast toastLength = Toast.LENGTH_SHORT,
      }) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: toastLength,
      gravity: toastGravity,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      fontSize: 16.0,
      backgroundColor: Colors.grey,
    );
  }

  static final log = Logger(printer: PrettyPrinter(methodCount: 1));

  /* 숫자 쉼표 포맷 */
  static final number = NumberFormat("#,###");

  /* List<textController> dispose */
  static void disposeControllers(List<TextEditingController> controllers) {
    for (final controller in controllers) {
      controller.dispose();
    }
  }

  /* unfocus 함수 */
  static void makeUnFocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  /* statusBar 색상 설정 */
  static void setStatusBarColor({
    required Color statusBarColor,
    required Brightness statusBarBrightness,
    required Color systemNavigationBarColor,
  }) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: statusBarColor,
      statusBarBrightness: statusBarBrightness,
      statusBarIconBrightness: Brightness.values.where((element) => element != statusBarBrightness).first,
      systemNavigationBarColor: systemNavigationBarColor,
      systemNavigationBarIconBrightness: Brightness.values.where((element) => element != statusBarBrightness).first,
      systemNavigationBarDividerColor: systemNavigationBarColor,
    ));
  }


  /* 핸드폰번호에 '-' 넣기 */
  static String formatPhoneNumber(String phoneNumber) {
    // 길이가 11이고, 숫자만 포함된 경우에만 형식을 변경
    if (RegExp(r'^\d{11}$').hasMatch(phoneNumber)) {
      // 예: 01012345678 => 010-1234-5678
      return '${phoneNumber.substring(0, 3)}-${phoneNumber.substring(3, 7)}-${phoneNumber.substring(7, 11)}';
    } else {
      // 그 외의 경우, 입력값 그대로 반환
      return phoneNumber;
    }
  }
  static String googleVerificationId = '';
  static PhoneAuthCredential? credential;
}