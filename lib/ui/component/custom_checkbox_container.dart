import 'package:flutter/material.dart';
import '../../const/value/colors.dart';
import '../../const/value/text_style.dart';


class CustomCheckboxContainer extends StatelessWidget {
  final String title;
  final bool isSelected;
  final void Function()? onTap;

  const CustomCheckboxContainer({
    required this.title,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
            color: isSelected ? colorGreen900 : colorGray300,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TS.s16w500(colorGray900),
            ),
            Icon(
              Icons.check,
              color: isSelected ? colorGreen900 : colorGray300,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
