import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tennisreminder/const/color.dart';
import 'package:uuid/uuid.dart';

import '../model/model_member.dart';


class NewMember extends StatefulWidget {
  const NewMember({super.key});

  @override
  _NewMemberState createState() => _NewMemberState();
}

class _NewMemberState extends State<NewMember> {
  final TextEditingController _memberIdEditingController = TextEditingController();
  final TextEditingController _pwEditingController = TextEditingController();
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _phoneEditingController = TextEditingController();
  final TextEditingController _locationEditingController = TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  bool _areAllFieldsFilled = false;

  @override
  void initState() {
    super.initState();
    _memberIdEditingController.addListener(_checkFields);
    _pwEditingController.addListener(_checkFields);
    _nameEditingController.addListener(_checkFields);
    _phoneEditingController.addListener(_checkFields);
    _locationEditingController.addListener(_checkFields);
    _emailEditingController.addListener(_checkFields);
  }

  void _checkFields() {
    setState(() {
      _areAllFieldsFilled =
          _memberIdEditingController.text.isNotEmpty &&
              _pwEditingController.text.isNotEmpty &&
              _nameEditingController.text.isNotEmpty &&
              _phoneEditingController.text.isNotEmpty &&
              _locationEditingController.text.isNotEmpty&&
      _emailEditingController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('회원가입'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '회원 아이디',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Color(0xff87857a),
              ),
            ),
            TextField(
              controller: _memberIdEditingController,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              onChanged: (_) => _checkFields(),
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffe6e3dd), // 변경하려는 색상
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              '비밀번호',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Color(0xff87857a),
              ),
            ),
            TextField(
              controller: _pwEditingController,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              onChanged: (_) => _checkFields(),
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffe6e3dd), // 변경하려는 색상
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            const Text(
              '이름',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Color(0xff87857a),
              ),
            ),
            TextField(
              controller: _nameEditingController,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              onChanged: (_) => _checkFields(),
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffe6e3dd), // 변경하려는 색상
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              '전화번호',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Color(0xff87857a),
              ),
            ),
            TextField(
              controller: _phoneEditingController,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              onChanged: (_) => _checkFields(),
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffe6e3dd), // 변경하려는 색상
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              '주소',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Color(0xff87857a),
              ),
            ),
            TextField(
              controller: _locationEditingController,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              onChanged: (_) => _checkFields(),
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffe6e3dd), // 변경하려는 색상
                  ),
                ),
              ),
            ),
            const Text(
              'E-mail',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Color(0xff87857a),
              ),
            ),
            TextField(
              controller: _emailEditingController,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              onChanged: (_) => _checkFields(),
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffe6e3dd), // 변경하려는 색상
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_areAllFieldsFilled) {
                        final id = const Uuid().v4();
                        ModelMember modelmember = ModelMember(
                          id: id,
                          memberid: _memberIdEditingController.text,
                          pw: _pwEditingController.text,
                          name: _nameEditingController.text,
                          phone: _phoneEditingController.text,
                          location: _locationEditingController.text,
                          email: _emailEditingController.text,
                        );
                        await FirebaseFirestore.instance.collection('member').doc(modelmember.id).set(modelmember.toJson());
                        Navigator.pop(context, modelmember);
                      } else {
                        // 필드가 하나 이상 비어있는 경우
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
                    }, // onPressed 블록 끝에 세미콜론(;) 제거
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(4),
                      backgroundColor: _areAllFieldsFilled ? colorGreen900 : colorGray300, // 필드가 모두 채워져 있으면 검은색, 아니면 회색
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      '저장',
                      style: TextStyle(
                        color: colorWhite,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _memberIdEditingController.dispose();
    _pwEditingController.dispose();
    _nameEditingController.dispose();
    _phoneEditingController.dispose();
    _locationEditingController.dispose();
    _emailEditingController.dispose();
    super.dispose();
  }
}
