import 'package:flutter/material.dart';
import 'package:tennisreminder/service/provider/providers.dart';

import '../const/color.dart';
import '../const/text_style.dart';
import 'drawmenu/drawer_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('homescreen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

          ],
        ),
      ),

      endDrawer: DrawerMenu(),
    );
  }
}


/*

            ValueListenableBuilder(
              valueListenable: userNotifier,
              builder: (context, userMe, child) => Column(
                children: [
                  Text('My email : ${userMe!.email}', style: TS.s15w500(colorGray900)),
                  if (userMe.isAdmin) const Text('admin만 보임', style: TS.s15w500(colorGray900)),
                ],
              ),
            ),

 */