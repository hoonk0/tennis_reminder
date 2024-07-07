import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tennisreminder/const/color.dart';

import '../../../../const/text_style.dart';

class SettingMyPage extends StatelessWidget {
  const SettingMyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Account Management',
            style: GoogleFonts.anton(
              textStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                color: colorGreen900,
                fontSize: 24,
              ),
            ),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

            SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '사용자 정보',
                    style: TS.s18w700(colorGreen900),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '로그인 아이디',
                    style: TS.s14w400(colorGreen900),
                  ),
                  IconButton(
                    onPressed: () {

                    },
                    icon: const Icon(Icons.arrow_forward),
                    color: colorGreen900,
                  ),
                ],
              ),
            ),



          ],
        ),
      ),
    );
  }
}
