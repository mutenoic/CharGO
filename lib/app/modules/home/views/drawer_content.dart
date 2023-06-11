import 'package:chargo/app/modules/home/components/drawer_content_tile.dart';
import 'package:chargo/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DrawerContent extends GetView<HomeController> {
  DrawerContent({super.key});

  final UserContent = [
    const ContentTile(title: "Карти", icon: Icon(Icons.map), index: 0),
    const ContentTile(title: "Карти", icon: Icon(Icons.map), index: 2),
    const ContentTile(title: "Карти", icon: Icon(Icons.map), index: 3),
    const ContentTile(title: "Карти", icon: Icon(Icons.map), index: 4),
  ];

  final UserSettings = [
    const ContentTile(title: "Профил", icon: Icon(Icons.person), index: 1),
    const ContentTile(title: "Излез", icon: Icon(Icons.logout), index: -1),
  ];

  final AnonContent = [
    const ContentTile(title: "Карти", icon: Icon(Icons.map), index: 0),
    const ContentTile(title: "Влез в акаунт", icon: Icon(Icons.login), index: 3),
    const ContentTile(title: "Регистрирай акаунт", icon: Icon(Icons.app_registration), index: 3),
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
