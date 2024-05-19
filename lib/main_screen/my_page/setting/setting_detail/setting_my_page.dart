
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tennisreminder/const/color.dart';
import '../../../../../const/text_style.dart';
import '../../../../model/model_member.dart';

class SettingMyPage extends StatefulWidget {
  final ModelMember modelMember;
  const SettingMyPage({super.key, required this.modelMember});

  @override
  State<SettingMyPage> createState() => _SettingMyPageState();
}

class _SettingMyPageState extends State<SettingMyPage> {


  TextEditingController tecId = TextEditingController();
  TextEditingController tecMemberid = TextEditingController();
  TextEditingController tecPw = TextEditingController();
  TextEditingController tecName = TextEditingController();
  TextEditingController tecPhone = TextEditingController();
  TextEditingController tecLocation = TextEditingController();
  TextEditingController tecEmail = TextEditingController();

  @override
  void initState() {
    super.initState();
    tecId.addListener(_checkFields);
    tecMemberid.addListener(_checkFields);
    tecPw.addListener(_checkFields);
    tecName.addListener(_checkFields);
    tecPhone.addListener(_checkFields);
    tecLocation.addListener(_checkFields);
    tecEmail.addListener(_checkFields);

    tecId = TextEditingController(text: widget.modelMember.id);
    tecMemberid = TextEditingController(text: widget.modelMember.memberid);
    tecPw = TextEditingController(text: widget.modelMember.pw);
    tecName = TextEditingController(text: widget.modelMember.name);
    tecPhone = TextEditingController(text: widget.modelMember.phone);
    tecLocation = TextEditingController(text: widget.modelMember.location);
    tecEmail = TextEditingController(text: widget.modelMember.email);

  }

  void _checkFields() {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('개인 정보 수정'), // 앱바 제목
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [

              const Text('아이디'), // 제목 입력 레이블
              TextField(
                controller: tecMemberid,
                style: const TS.s14w400(colorBlack),
              ),// 선택된 이미지 미리보기

              const Text('password'), // 제목 입력 레이블
              TextField(
                controller: tecPw,
                style: const TS.s14w400(colorBlack),
              ), // 제목 입력 필드

              const Text('이름'), // 가격 입력 레이블
              TextField(
                controller: tecName,
                style: const TS.s14w400(colorBlack),
              ),

              const Text('전화번호'), // 제목 입력 레이블
              TextField(
                controller: tecPhone,
                style: const TS.s14w400(colorBlack),
              ), // 제목 입력 필드// 가격 입력 필드

              const Text('위치'), // 내용 입력 레이블
              TextField(
                controller: tecLocation,
                style: const TS.s14w400(colorBlack),
              ),

              const Text('이메일'), // 내용 입력 레이블
              TextField(
                controller: tecEmail,
                style: const TS.s14w400(colorBlack),
              ),

              IconButton(
                icon: const Icon(Icons.save),
                onPressed: () async {
                  ModelMember updatedMember = ModelMember(
                    id: widget.modelMember.id,
                    memberid: tecMemberid.text,
                    pw: tecPw.text,
                    name: tecName.text,
                    phone: tecPhone.text,
                    location: tecLocation.text,
                    email: tecEmail.text,
                  );
                  await FirebaseFirestore.instance.collection('member').doc(widget.modelMember.id).update(updatedMember.toJson());
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
    tecId.dispose();
    tecMemberid.dispose();
    tecPw.dispose();
    tecName.dispose();
    tecPhone.dispose();
    tecLocation.dispose();
    tecEmail.dispose();
    super.dispose();
  }

}

