import 'package:animations/animations.dart';
import 'package:chargo/app/modules/home/views/drawer_content.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:inner_drawer/inner_drawer.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomeController());
    return Stack(
      children: [
        Obx(
          () => InnerDrawer(
            key: controller.innerDrawerKey,
            onTapClose: true,
            colorTransitionChild: Colors.transparent,
            colorTransitionScaffold: Colors.transparent,
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 15),
                color: Colors.black26,
                blurRadius: 30,
                spreadRadius: 10,
              )
            ],
            offset: const IDOffset.only(left: 0.5),
            scale: const IDOffset.horizontal(0.8), // set the offset in both directions
            proportionalChildArea: false, // default true
            borderRadius: 50, // default 0
            leftAnimationType: InnerDrawerAnimation.static,
            swipe: controller.selectedPageIndex.value != 0 ? true : false,
            backgroundDecoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
            ),
            leftChild: DrawerContent(),
            scaffold: Obx(
              () => PageTransitionSwitcher(
                duration: const Duration(milliseconds: 600),
                transitionBuilder: (child, primaryAnimation, secondaryAnimation) => SharedAxisTransition(
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.vertical,
                  child: child,
                ),
                child: controller.pages[controller.selectedPageIndex.value],
              ),
            ),
          ),
        ),
        Obx(() {
          var dontHaveInternet = controller.connectivityStatus.value != ConnectivityResult.wifi &&
              controller.connectivityStatus.value != ConnectivityResult.mobile;

          return AnimatedSlide(
            duration: const Duration(milliseconds: 300),
            offset: dontHaveInternet ? Offset.zero : const Offset(0, -1),
            child: Container(
              padding: const EdgeInsets.only(bottom: 5),
              color: Colors.red,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).viewInsets.top + 60,
              alignment: Alignment.bottomCenter,
              child: Text(
                "Нямате интернет връзка",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
              ),
            ),
          );
        }),
      ],
    );
  }
}
