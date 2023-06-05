import 'package:chargo/app/modules/home/views/drawer_content.dart';
import 'package:chargo/app/modules/home/views/main_screen_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:inner_drawer/inner_drawer.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomeController());
    return InnerDrawer(
      key: controller.innerDrawerKey,
      onTapClose: true, // default false
      colorTransitionChild: Theme.of(context).colorScheme.surface, // default Color.black54
      colorTransitionScaffold: Colors.transparent, // default Color.black54

      boxShadow: const [
        BoxShadow(
          offset: Offset(0, 15),
          color: Colors.black26,
          blurRadius: 30,
          spreadRadius: 10,
        )
      ],

      velocity: 0.6,

      offset: const IDOffset.only(left: 0.5),
      scale: const IDOffset.horizontal(0.8), // set the offset in both directions
      proportionalChildArea: false, // default true
      borderRadius: 50, // default 0
      leftAnimationType: InnerDrawerAnimation.static,

      swipe: false,
      backgroundDecoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      leftChild: const DrawerContent(),
      scaffold: const MainScreen(),
    );
  }
}
