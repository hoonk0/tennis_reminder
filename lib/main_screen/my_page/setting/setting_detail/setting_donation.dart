import 'package:flutter/material.dart';

class SettingDonation extends StatelessWidget {
  const SettingDonation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DONATION')
      ),
      body: Center(
        child: const Column(
          children: [
            Text(
              '신한은행 000-00011122',

            )
          ],
        ),
      ),
    );
  }
}
