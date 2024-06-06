import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:sizer/sizer.dart';
import 'package:tennisreminder/start/login_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {

  //kakao login
  WidgetsFlutterBinding.ensureInitialized();

  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: '5796f23d8e91feb7fe43c219fbdf4f01',
    javaScriptAppKey: '36fec2addf0579f3883e41811e7d2ee2',
  );



  //firebase login

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        home: LoginScreen(),
        theme: ThemeData(
          textTheme: GoogleFonts.nanumGothicTextTheme(
            Theme.of(context).textTheme,
          ),
        ),

      ),
    ),
  );
}
