import 'dart:async';

import 'package:chargo/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class DrawerContent extends GetView<HomeController> {
  const DrawerContent({super.key});

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
              child: Column(
                children: [
                  ContentTile("Карти", const Icon(Icons.map), 0),
                  ContentTile("Профил", const Icon(Icons.person), 1),
                  ContentTile("Карти", const Icon(Icons.map), 2),
                  ContentTile("Карти", const Icon(Icons.map), 3),
                  ContentTile("Карти", const Icon(Icons.map), 4),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                child: ContentTile("Карти", const Icon(Icons.map), 5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ContentTile(String title, Icon icon, int index) {
    return Obx(
      () => ListTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              scale: controller.selectedPageIndex.value == index ? 1 : 0,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutExpo,
              child: Container(
                width: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(Get.context!).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            icon,
          ],
        ),
        selected: controller.selectedPageIndex.value == index,
        title: Text(title),
        onTap: () {
          controller.selectedPageIndex.value = index;
          Timer(
            300.ms,
            () => controller.toggleDrawer(),
          );
        },
      ),
    );
  }
}
