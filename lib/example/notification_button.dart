import 'package:flutter/material.dart';
import 'notification.dart';

class NotificationButton extends StatefulWidget {
  const NotificationButton({Key? key}) : super(key: key);

  @override
  _NotificationButtonState createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<NotificationButton> {
  @override
  void initState() {
    super.initState();
    FlutterLocalNotification.init();
    Future.delayed(const Duration(seconds: 3),
            () => FlutterLocalNotification.requestNotificationPermission());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("테스트"),
      ),
      body: Center(
        child: TextButton(
          onPressed: () => FlutterLocalNotification.showNotification(),
          child: const Text("알림"),
        ),
      ),
    );
  }
}
