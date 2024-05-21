import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tennisreminder/model/model_court.dart';
import 'package:tennisreminder/service/utils/utils.dart';
import 'package:uuid/uuid.dart';

import '../../../../../const/color.dart';
import '../../../../../const/text_style.dart';

class NewCourtRegister extends StatefulWidget {
  const NewCourtRegister({super.key});

  @override
  State<NewCourtRegister> createState() => _NewCourtRegisterState();
}

class _NewCourtRegisterState extends State<NewCourtRegister> {
  TextEditingController tecLocation = TextEditingController();
  TextEditingController tecPhone = TextEditingController();
  TextEditingController tecWebsite = TextEditingController();
  TextEditingController tecNotice = TextEditingController();
  TextEditingController tecInformation = TextEditingController();
  TextEditingController tecName = TextEditingController();
  bool _areAllFieldsFilled = false;
  XFile? selectedXFile;
  String _imagePath = '';

  @override
  void initState() {
    super.initState();
    tecLocation.addListener(_checkFields);
    tecPhone.addListener(_checkFields);
    tecWebsite.addListener(_checkFields);
    tecNotice.addListener(_checkFields);
    tecInformation.addListener(_checkFields);
    tecName.addListener(_checkFields);
  }

  void _checkFields() {
    setState(() {
      _areAllFieldsFilled = tecLocation.text.isNotEmpty &&
          tecPhone.text.isNotEmpty &&
          tecName.text.isNotEmpty &&
          tecWebsite.text.isNotEmpty &&
          tecNotice.text.isNotEmpty &&
          tecInformation.text.isNotEmpty;
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    selectedXFile = await picker.pickImage(source: ImageSource.gallery);

    if (selectedXFile != null) {
      setState(() {
        _imagePath = selectedXFile!.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('새 코트 등록_관리자'), // 앱바 제목
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Select Image'), // 이미지 선택 버튼
              ),
              if (_imagePath.isNotEmpty)
                Image.file(
                  File(_imagePath),
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),

              const Text('테니스장명'), // 제목 입력 레이블
              TextField(
                controller: tecName,
                style: TS.s14w400(colorBlack),
              ), // 선택된 이미지 미리보기

              const Text('주소'), // 제목 입력 레이블
              TextField(
                controller: tecLocation,
                style: TS.s14w400(colorBlack),
              ), // 제목 입력 필드

              const Text('전화번호'), // 가격 입력 레이블
              TextField(
                controller: tecPhone,
                style: TS.s14w400(colorBlack),
                keyboardType: TextInputType.number, // 숫자 키패드 활성화
              ),

              Text('예약사이트 바로가기'), // 제목 입력 레이블
              TextField(
                controller: tecWebsite,
                style: TS.s14w400(colorBlack),
              ), // 제목 입력 필드// 가격 입력 필드

              const Text('안내사항'), // 내용 입력 레이블
              TextField(
                controller: tecNotice,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                style: TS.s14w400(colorBlack),
              ),

              const Text('코트 정보'), // 내용 입력 레이블
              TextField(
                controller: tecInformation,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                style: TS.s14w400(colorBlack),
              ),

              IconButton(
                icon: const Icon(Icons.save),
                onPressed: () async {
                  if (_areAllFieldsFilled) {
                    final id = const Uuid().v4();
                    debugPrint("11");
                    final List<String> listImgUrl = await Utils.getImgUrlXFile([selectedXFile]);
                    debugPrint("listImgUrl ${listImgUrl}");
                    if (listImgUrl.isEmpty) {
                      Fluttertoast.showToast(msg: '사진을 선택하세요');
                      return;
                    }

                    ModelCourt modelCourt = ModelCourt(
                      id: id,
                      name: tecName.text,
                      location: tecLocation.text,
                      information: tecInformation.text,
                      phone: tecPhone.text,
                      notice: tecNotice.text,
                      website: tecWebsite.text,
                      imagePath: listImgUrl.first,
                    );

                    await FirebaseFirestore.instance.collection('court').doc(modelCourt.id).set(modelCourt.toJson());
                    Navigator.pop(context, modelCourt);
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('입력 오류'),
                          content: const Text('모든 필드를 작성해주세요.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('확인'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    tecWebsite.dispose();
    tecName.dispose();
    tecInformation.dispose();
    tecNotice.dispose();
    tecPhone.dispose();
    tecLocation.dispose();
    super.dispose();
  }
}
