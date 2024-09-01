import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:collection/collection.dart';

import '../../../ui/component/custom_toast.dart';
import '../../static/global.dart';
import '../../text_style.dart';
import '../../value/colors.dart';

class Utils {
  static Future<List<String>> getImgUrlXFile(List<XFile?> listXFile) async {
    debugPrint("22 ${listXFile}");
    List<UploadTask> listUploadTasks = [];
    List<TaskSnapshot> listTaskSnapshot = [];
    List<String> listImgUrls = [];
    final uuid = const Uuid().v4().substring(0, 6);
    debugPrint("55");
    // 서버에 사진 올리는 코드
    listUploadTasks =
        listXFile.mapIndexed<UploadTask>((index, xFile) => FirebaseStorage.instance.ref('사진등록($uuid)/$index').putFile(File(xFile!.path))).toList();
    listTaskSnapshot = await Future.wait(listUploadTasks);
    debugPrint("44");
    // 올라간 사진의 url을 받는 코드
    final futureImgUrls = listTaskSnapshot.map((snapShot) => snapShot.ref.getDownloadURL()).toList();
    listImgUrls = await Future.wait(futureImgUrls);
    debugPrint("33 ${listImgUrls}");
    return listImgUrls;
  }

  /// 토스트 메세지
  static void toast({
    required String desc,
    int duration = 1000,
    ToastGravity toastGravity = ToastGravity.BOTTOM,
  }) {
    FToast fToast = FToast();
    fToast.init(Global.contextSplash!);

    Widget toast = Container(
      margin: const EdgeInsets.only(bottom: 25),
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorGrayShadow70,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            desc,
            style: const TS.s14w500(colorWhite),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: toastGravity,
      isDismissable: true,
      toastDuration: Duration(milliseconds: duration),
    );
  }
}
