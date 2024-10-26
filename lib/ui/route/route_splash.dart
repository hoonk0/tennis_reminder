import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sizer/sizer.dart';
import 'package:tennisreminder/ui/route/auth/route_auth_login.dart';
import 'package:tennisreminder/ui/route/route_main.dart';

import '../../service/stream/stream_me.dart';
import '../../static/global.dart';

BuildContext? contextMain;

class RouteSplash extends ConsumerStatefulWidget {
  const RouteSplash({super.key});

  @override
  ConsumerState<RouteSplash> createState() => _RouteSplashState();
}

class _RouteSplashState extends ConsumerState<RouteSplash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUserAndInitData();
  }

  Future<void> checkUserAndInitData() async {
    final pref = await SharedPreferences.getInstance();
    final uid = pref.getString('uid');

    try {
      Global.uid = uid;

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        if (uid == null) {
          debugPrint('uid null');
          // uid가 null인 경우 로그인 화면으로 이동
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RouteAuthLogin()));
        } else {
          // uid가 있는 경우 데이터 초기화
          debugPrint('uid login');
          StreamMe.listenMe(ref);
          await Future.delayed(Duration(milliseconds: 100));
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RouteMain(), settings: const RouteSettings(name: 'home')));
        }
      });
    } catch (e) {
      // 에러 로그 출력
      debugPrint('Error occurred: $e');
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RouteAuthLogin()));
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Global.contextSplash = context;
  }

  @override
  Widget build(BuildContext context) {
    Global.contextSplash = context;
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
