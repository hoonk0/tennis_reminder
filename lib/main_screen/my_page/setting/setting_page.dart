import 'package:flutter/material.dart';
import 'package:tennisreminder/const/color.dart';
import 'package:tennisreminder/const/text_style.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

        body: CustomPaint(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    height: 200,
                    color: Color(0xfff2efef),
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Color(0xfff2efef),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              children: [
                                Text(
                                  'Account',
                                  style: TS.s24w700(colorGreen900),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Color(0xffe8e8e8),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Icon(Icons.contact_support_rounded, color: colorGreen900),
                                Text(
                                  '개인정보',
                                  style: TS.s20w500(colorGreen900),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Color(0xfff2efef),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              children: [
                                Text(
                                  'Notifications',
                                  style: TS.s20w500(colorGreen900),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Color(0xffe8e8e8),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Text(
                                  '공지사항',
                                  style: TS.s20w500(colorGreen900),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Color(0xfff2efef),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Text(
                                  '고객센터',
                                  style: TS.s20w500(colorGreen900),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  Expanded(
                    child: Container(
                      color: Color(0xffe8e8e8),
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/*
class HalfCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red // 배경색을 빨간색으로 설정
      ..style = PaintingStyle.fill;

    final rect = Rect.fromLTWH(
      0,
      0,
      size.width,
      size.height,
    );

    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..arcTo(rect, math.pi, math.pi, false)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
*/