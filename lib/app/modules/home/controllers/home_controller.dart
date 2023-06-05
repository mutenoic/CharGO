import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inner_drawer/inner_drawer.dart';

class HomeController extends GetxController {
  final innerDrawerKey = GlobalKey<InnerDrawerState>();

  void toggleDrawer() {
    innerDrawerKey.currentState?.toggle();
  }

  final connectivityStatus = ConnectivityResult.none.obs;

  @override
  void onInit() {
    getSetConnectivity();
    super.onInit();
  }

  Future<void> getSetConnectivity() async {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connectivityStatus.value = result;
    });
  }

  final selectedPageIndex = 0.obs;
}
