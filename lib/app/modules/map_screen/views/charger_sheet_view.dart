import 'package:chargo/app/modules/home/components/charger_tile.dart';
import 'package:chargo/app/modules/map_screen/controllers/map_controller.dart';
import 'package:chargo/models/charger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';
import 'package:snapping_sheet_2/snapping_sheet.dart';

class ChargerSheet extends StatelessWidget {
  ChargerSheet({super.key});

  final controller = Get.find<MapController>();

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).viewInsets.bottom > 0 && controller.sheetSize < 400) {
      controller.bottomController.snapToPosition(
        const SnappingPosition.factor(
          positionFactor: 0.7,
          snappingCurve: Curves.elasticOut,
          snappingDuration: Duration(milliseconds: 1000),
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
              itemCount: 50,
              itemBuilder: (context, index) => ChargerTile(
                charger: Charger(
                  description: "fs",
                  name: "KYS",
                  location: const LatLng(0, 0),
                  price: 15,
                  type: "SD",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
