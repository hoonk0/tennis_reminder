import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sizer/sizer.dart';
import 'package:tennisreminder/ui/route/auth/route_auth_login.dart';
import 'package:tennisreminder/ui/route/route_main.dart';

import '../../const/service/stream/stream_me.dart';
import '../../const/static/global.dart';
import 'auth/route_auth_login(not use).dart';

class RouteSplash extends ConsumerStatefulWidget {
  const RouteSplash({super.key});

  @override
  ConsumerState<RouteSplash> createState() => _RouteSplashState();
}

class _RouteSplashState extends ConsumerState<RouteSplash> {
  @override
  void initState() {
    super.initState();
    _checkUserAndInitData();
/*    Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
          ///const RouteAuthLogin(),
          const RouteAuthLogin(), // sns 연결
        ),
      );
    });*/
  }

  Future<void> _checkUserAndInitData() async {
    final pref = await SharedPreferences.getInstance();
    final uid = pref.getString('uid');

    try {
      Global.uid = uid;

      WidgetsBinding.instance.addPostFrameCallback(
            (timeStamp) async {
          /// FirebaseAuth에 등록되어 있지 않음: 아무것도 안함
          if (uid == null) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => RouteAuthLogin()));
          }

          /// uid 를 들고 있을 때
          else {
            await Future.delayed(Duration(milliseconds: 2000));

            StreamMe.listenMe(ref);

            WidgetsBinding.instance.endOfFrame.then((value) async {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const RouteMain(), settings: const RouteSettings(name: 'home')));
            });
          }
        },
      );
    } catch (e) {
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
