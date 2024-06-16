import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tennisreminder/const/text_style.dart';
import 'package:tennisreminder/main_screen/mainscreen.dart';
import 'package:tennisreminder/model/model_member.dart';
import 'package:tennisreminder/service/provider/providers.dart';
import 'package:tennisreminder/start/login_screen.dart';

import '../../const/color.dart';

class RouteSplash extends StatefulWidget {
  const RouteSplash({super.key});

  @override
  State<RouteSplash> createState() => _RouteSplashState();
}

class _RouteSplashState extends State<RouteSplash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUser();
  }

  Future<void> checkUser() async {
    final pref = await SharedPreferences.getInstance();
    final uid = pref.getString('uid');
    if (uid == null) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
    } else {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MainScreen(selectedIndex: 0)));
      final userDs = await FirebaseFirestore.instance.collection('member').doc(uid).get();
      userNotifier.value = ModelMember.fromJson(userDs.data()!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Text('로딩 화면', style: TS.s15w500(colorGray50)),
        ),
      )),
    );
  }
}
