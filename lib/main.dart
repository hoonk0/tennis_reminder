import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:sizer/sizer.dart';
import 'package:tennisreminder/example/notification.dart';
import 'package:tennisreminder/main_screen/home/splash_screen.dart';
import 'package:url_strategy/url_strategy.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {



  //kakao login
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: '5796f23d8e91feb7fe43c219fbdf4f01',
    javaScriptAppKey: '36fec2addf0579f3883e41811e7d2ee2',
  );

  setPathUrlStrategy();
  //firebase login

  runApp(
    Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        home: RouteSplash(),
        theme: ThemeData(
          textTheme: GoogleFonts.nanumGothicTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
      ),
    ),
  );
}
