import 'package:flutter/material.dart';
import 'notification.dart';

class NotificationButton extends StatefulWidget {
  const NotificationButton({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
