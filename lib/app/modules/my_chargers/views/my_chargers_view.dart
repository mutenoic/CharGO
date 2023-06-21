import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/my_chargers_controller.dart';

class MyChargersView extends GetView<MyChargersController> {
  const MyChargersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyChargersView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MyChargersView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
