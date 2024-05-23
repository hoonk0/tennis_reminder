import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:sizer/sizer.dart';
import 'package:tennisreminder/start/login_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) => const MaterialApp(
        home: LoginScreen(),
      ),
    ),
  );
}
