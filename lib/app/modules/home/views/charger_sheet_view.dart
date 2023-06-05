import 'package:chargo/app/modules/home/controllers/main_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChargerSheet extends StatelessWidget {
  ChargerSheet({super.key});

  final controller = Get.find<MainScreenController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          Obx(
            () => AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOutQuart,
              color: Colors.white,
              width: controller.sheetSize.value > 500 ? 350 : 200,
              child: const TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  label: Text("Локация"),
                ),
                autofocus: false,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              controller: controller.scrollController,
              children: [
                for (int i = 0; i < 200; i++) const Text("Hello world"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
