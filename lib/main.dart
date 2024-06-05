import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tennisreminder/start/login_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
