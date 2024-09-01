import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import '../../const/static/global.dart';
import 'auth/route_auth_login.dart';

class RouteSplash extends StatefulWidget {
  const RouteSplash({super.key});

  @override
  State<RouteSplash> createState() => _RouteSplashState();
}

class _RouteSplashState extends State<RouteSplash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const RouteAuthLogin(),
        ),
      );
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Global.contextSplash = context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 100.w,
          child: Image.asset(
            'assets/images/logo_courtvibe.png',
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
