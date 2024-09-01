import 'package:flutter/material.dart';
import 'package:tennisreminder/const/color.dart';

import '../../../../const/gaps.dart';



class DialogDeny extends StatelessWidget {
  final String title;

  const DialogDeny({
    required this.title,

    super.key,
  });
//
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Gaps.v56,

/*            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),*/
            Icon(
              Icons.check_circle,
              size: 48,
              color: colorGreen600,
            ),
            Gaps.v26,
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            Gaps.v44,
          ],
        ),
      ),
    );
  }
}
