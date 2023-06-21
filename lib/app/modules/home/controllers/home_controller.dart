import 'package:chargo/app/modules/add_credits/views/add_credits_view.dart';
import 'package:chargo/app/modules/home/views/auth_sheet.dart';
import 'package:chargo/app/modules/map_screen/views/map_view.dart';
import 'package:chargo/app/modules/my_chargers/views/my_chargers_view.dart';
import 'package:chargo/app/modules/profile/views/profile_view.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inner_drawer/inner_drawer.dart';

class HomeController extends GetxController {
  final selectedPageIndex = 0.obs;

  final pages = [
    const MapScreen(),
    const ProfileView(),
    const MyChargersView(),
    const AddCreditsView(),
  ];

  final innerDrawerKey = GlobalKey<InnerDrawerState>();

  void toggleDrawer() {
    if (FirebaseAuth.instance.currentUser == null) {
      showModalBottomSheet(
        showDragHandle: true,
        context: Get.context!,
        builder: (context) => const AuthSheet(),
      );
      return;
    }

    innerDrawerKey.currentState?.toggle();
  }

  final connectivityStatus = ConnectivityResult.none.obs;

  @override
  void onInit() {
    getSetConnectivity();
    super.onInit();
  }

  Future<void> getSetConnectivity() async {
    connectivityStatus.value = await Connectivity().checkConnectivity();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connectivityStatus.value = result;
    });
  }
}
