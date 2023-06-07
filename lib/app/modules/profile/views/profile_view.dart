import 'package:chargo/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(
      () => ProfileController(),
    );

    final drawerController = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gas"),
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () => drawerController.toggleDrawer(),
          icon: const Icon(Icons.menu),
        ),
      ),
    );
  }
}
