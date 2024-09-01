import 'dart:io';
import 'package:flutter/material.dart';

class Global {
  /// uid
  static final ValueNotifier<String?> vnUidUser = ValueNotifier(null);

  /// Main Tab Index
  static final ValueNotifier<int> vnIndexMainTab = ValueNotifier(0);

  /// context splash
  static BuildContext? contextSplash;

  /// main scaffold key
  static final GlobalKey<ScaffoldState> keyScaffoldMain = GlobalKey<ScaffoldState>();

  /// 갤러리폴더 이름들
  static List<String> listGalleryNames = [];

  /// 선택한 갤러리폴더
  static ValueNotifier<String> vnGallerySelected = ValueNotifier(Platform.isIOS ? 'Recents' : 'Recent');
}
