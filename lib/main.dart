
import 'package:flutter/material.dart';
import 'package:tennisreminder/start/login_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
       MaterialApp(
        home: LoginScreen(),
      ),

  );
}

