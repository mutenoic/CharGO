import 'dart:math';

import 'package:chargo/app/modules/home/components/charger_tile.dart';
import 'package:chargo/app/modules/map_screen/controllers/map_controller.dart';
import 'package:chargo/models/charger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

class ChargerSheet extends StatelessWidget {
  ChargerSheet({super.key, required this.scrollController});

  final ScrollController scrollController;

  final controller = Get.find<MapController>();

  void check() {
    if (MediaQuery.of(Get.context!).viewInsets.bottom > 0 && controller.sheetSize < 450) {
      controller.bottomController.snapToPosition(
        const SnappingPosition.factor(
          positionFactor: 0.9,
          snappingCurve: Curves.elasticOut,
          snappingDuration: Duration(milliseconds: 1000),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    check();

    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          Obx(
            () => AnimatedContainer(
              margin: const EdgeInsets.only(bottom: 10),
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOutQuart,
              color: Colors.white,
              width: controller.sheetSize.value > 500 || MediaQuery.of(context).viewInsets.bottom > 0
                  ? MediaQuery.of(context).size.width - 50
                  : 200,
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
              controller: scrollController,
              cacheExtent: double.infinity,
              itemCount: 50,
              itemBuilder: (context, index) => ChargerTile(
                key: ValueKey(index),
                charger: Charger(
                  description: "$index",
                  name: "KYS",
                  location: const LatLng(0, 0),
                  price: 15,
                  type: Random().nextInt(9).toString(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
