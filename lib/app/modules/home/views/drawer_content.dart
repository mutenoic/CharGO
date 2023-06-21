import 'package:chargo/app/modules/home/components/drawer_content_tile.dart';
import 'package:chargo/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DrawerContent extends GetView<HomeController> {
  DrawerContent({super.key});

  final UserContent = [
    const ContentTile(title: "Карти", icon: Icon(Icons.map), index: 0),
    const ContentTile(title: "Мойте зарядни", icon: Icon(Icons.bolt), index: 2),
  ];

  final UserSettings = [
    const ContentTile(title: "Вкарай кредити", icon: Icon(Icons.attach_money), index: 3),
    const ContentTile(title: "Профил", icon: Icon(Icons.person), index: 1),
    const ContentTile(title: "Излез", icon: Icon(Icons.logout), index: -1),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark, systemStatusBarContrastEnforced: false),
    );
    return Container(
      color: Colors.transparent,
      child: Material(
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(left: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "CharGO",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Column(children: UserContent),
            ),
            Flexible(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: UserSettings,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
