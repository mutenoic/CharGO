import 'package:chargo/app/components/map_switcher.dart';
import 'package:chargo/app/modules/home/controllers/home_controller.dart';
import 'package:chargo/app/modules/home/controllers/main_screen_controller.dart';
import 'package:chargo/app/modules/home/views/charger_sheet_view.dart';
import 'package:chargo/app/services/geo_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snapping_sheet_2/snapping_sheet.dart';

class MainScreen extends GetView<MainScreenController> {
  const MainScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MainScreenController());

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent,
          systemStatusBarContrastEnforced: false,
          systemNavigationBarContrastEnforced: false,
        ),
        forceMaterialTransparency: true,
        centerTitle: true,
        toolbarHeight: 60,
        leadingWidth: 60,
        leading: Obx(() {
          return AnimatedScale(
            scale: controller.sheetSize.value > 600 ? 0 : 1,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutQuint,
            child: IconButton.filled(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              onPressed: () => Get.find<HomeController>().toggleDrawer(),
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
          );
        }),
      ),
      body: FutureBuilder(
        future: GeoService.getLocation(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: AlertDialog(
                icon: const Icon(
                  Icons.warning,
                  size: 40,
                ),
                iconColor: Colors.red,
                title: Text(
                  snapshot.error as String,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Loading...",
                    style: Theme.of(context).textTheme.headlineMedium,
                  )
                ],
              ),
            );
          }

          return SnappingSheet(
            lockOverflowDrag: true,
            controller: controller.bottomController,
            snappingPositions: const [
              SnappingPosition.factor(
                positionFactor: 0.25,
                snappingCurve: Curves.elasticOut,
                snappingDuration: Duration(milliseconds: 1000),
              ),
              SnappingPosition.factor(
                positionFactor: 0.5,
                snappingCurve: Curves.elasticOut,
                snappingDuration: Duration(milliseconds: 1000),
              ),
              SnappingPosition.factor(
                positionFactor: 0.9,
                snappingCurve: Curves.elasticOut,
                snappingDuration: Duration(milliseconds: 1000),
              ),
            ],
            allowScrolling: ({biggestSnapPos = 0, currentDragDirection, currentPos = 0, details, smallestSnapPos = 0}) {
              return true;
            },
            onSheetMoved: (positionData) => controller.sheetSize.value = positionData.pixels,
            grabbingHeight: 50,
            grabbing: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Center(
                child: Container(
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            sheetBelow: SnappingSheetContent(
                childScrollController: controller.scrollController, draggable: (p0) => true, child: ChargerSheet()),
            child: MapSwitcher(
              child: GoogleMap(
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: snapshot.data ?? const LatLng(50, 50),
                  zoom: 15,
                ),
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
                mapType: MapType.normal,
                onMapCreated: (mapControl) {
                  controller.MapController.complete(mapControl);
                },
              ),
            ),
          );
        },
      ),
      // bottomSheet: ChargerSheet(),
    );
  }
}
