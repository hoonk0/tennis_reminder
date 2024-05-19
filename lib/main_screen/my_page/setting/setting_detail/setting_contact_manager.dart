import 'package:flutter/material.dart';

class ContactManager extends StatelessWidget {
  const ContactManager({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('고객센터'),
      ),
      //건의사항, 문의사항 선택하게 해서 제목, 내용 추가로 받자
    );
  }
}
