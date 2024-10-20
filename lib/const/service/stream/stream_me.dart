
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tennisreminder/const/service/provider/providers.dart';

import '../../../ui/route/route_splash.dart';
import '../../model/model_user.dart';
import '../../static/global.dart';
import '../../value/keys.dart';
import '../provider/providers.dart';
import '../provider/providers.dart';
import '../utils/utils.dart';

class StreamMe {
  static StreamSubscription? streamSubscription;

  static Future<void> listenMe(WidgetRef ref) async {
    debugPrint("listenMe ${Global.uid}");
    streamSubscription = FirebaseFirestore.instance.collection(keyUser).doc(Global.uid).snapshots().listen(
      (event) async {
        debugPrint('listenMe 업데이트');

        Global.userNotifier.value = ModelUser.fromJson(event.data()!);



        try {
          Global.userNotifier.value = ModelUser.fromJson(event.data()!);

        } catch (e, s) {
          Utils.toast(desc: 'This user is not exist');
          final pref = await SharedPreferences.getInstance();
          pref.remove(keyUid);
          Navigator.of(Global.contextSplash!).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const RouteSplash()), (route) => false);
        }
      },

    );
  }
}

