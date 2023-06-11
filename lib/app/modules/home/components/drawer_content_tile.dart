import 'dart:async';

import 'package:chargo/app/modules/home/controllers/home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class ContentTile extends StatelessWidget {
  const ContentTile({super.key, required this.title, required this.icon, required this.index});

  final String title;
  final Icon icon;
  final int index;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
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
        onTap: () async {
          switch (index) {
            case -1:
              await FirebaseAuth.instance.signOut();
              return;
          }

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
