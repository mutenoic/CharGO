import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inner_drawer/inner_drawer.dart';

class HomeController extends GetxController {
  final innerDrawerKey = GlobalKey<InnerDrawerState>();

  void toggleDrawer() {
    innerDrawerKey.currentState?.toggle();
  }
}
