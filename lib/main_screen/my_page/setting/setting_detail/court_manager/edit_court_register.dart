import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tennisreminder/const/color.dart';
import 'package:tennisreminder/model/model_court.dart';
import 'package:uuid/uuid.dart';

import '../../../../../const/text_style.dart';

class EditCourtRegister extends StatefulWidget {
  final ModelCourt modelCourt;
  const EditCourtRegister({super.key, required this.modelCourt});

  @override
  State<EditCourtRegister> createState() => _NewCourtRegisterState();
}

class _NewCourtRegisterState extends State<EditCourtRegister> {
  TextEditingController tecLocation = TextEditingController();
  TextEditingController tecPhone = TextEditingController();
  TextEditingController tecWebsite = TextEditingController();
  TextEditingController tecNotice = TextEditingController();
  TextEditingController tecInformation = TextEditingController();
  TextEditingController tecName = TextEditingController();
  bool _areAllFieldsFilled = false;
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

    tecLocation = TextEditingController(text: widget.modelCourt.location);
    tecPhone = TextEditingController(text: widget.modelCourt.phone);
    tecWebsite = TextEditingController(text: widget.modelCourt.website);
    tecNotice = TextEditingController(text: widget.modelCourt.notice);
    tecInformation = TextEditingController(text: widget.modelCourt.information);
    tecName = TextEditingController(text: widget.modelCourt.name);

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
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _imagePath = pickedImage.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('코트 정보 수'), // 앱바 제목
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
              ),// 선택된 이미지 미리보기

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
                style: TS.s14w400(colorBlack),
              ),

              const Text('코트 정보'), // 내용 입력 레이블
              TextField(
                controller: tecInformation,
                style: TS.s14w400(colorBlack),
              ),

              IconButton(
                icon: const Icon(Icons.save),
                onPressed: () async {
                  ModelCourt updatedCourt = ModelCourt(
                    id: widget.modelCourt.id,
                    name: tecName.text,
                    location: tecLocation.text,
                    information: tecInformation.text,
                    phone: tecPhone.text,
                    notice: tecNotice.text,
                    website: tecWebsite.text,
                    imagePath: widget.modelCourt.imagePath,
                  );
                  await FirebaseFirestore.instance.collection('court').doc(widget.modelCourt.id).update(updatedCourt.toJson());
                  Navigator.pop(context);
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
