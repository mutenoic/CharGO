import 'package:chargo/app/modules/home/controllers/main_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snapping_sheet_2/snapping_sheet.dart';

class ChargerSheet extends StatelessWidget {
  ChargerSheet({super.key});

  final controller = Get.find<MainScreenController>();

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).viewInsets.bottom > 0 && controller.sheetSize < 400) {
      controller.bottomController.snapToPosition(
        const SnappingPosition.factor(
          positionFactor: 0.7,
          snappingCurve: Curves.elasticOut,
          snappingDuration: Duration(seconds: 1),
        ),
      );
    }

    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          Obx(
            () => AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOutQuart,
              color: Colors.white,
              width: controller.sheetSize.value > 500 || MediaQuery.of(context).viewInsets.bottom > 0 ? 400 : 200,
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
            child: ListView.builder(
              itemCount: 50,
              itemBuilder: (context, index) => Text("Ebah maika ti: ${index + 1}"),
            ),
          ),
        ],
      ),
    );
  }
}
