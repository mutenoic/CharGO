import 'package:chargo/app/components/map_switcher.dart';
import 'package:chargo/app/modules/home/controllers/home_controller.dart';
import 'package:chargo/app/modules/map_screen/controllers/map_controller.dart';
import 'package:chargo/app/modules/map_screen/views/charger_sheet_view.dart';
import 'package:chargo/app/services/geo_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

class MapScreen extends GetView<MapController> {
  const MapScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MapController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        automaticallyImplyLeading: false,
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
                positionFactor: 0.3,
                snappingCurve: Curves.elasticOut,
                snappingDuration: Duration(milliseconds: 1000),
              ),
              SnappingPosition.factor(
                positionFactor: 0.90,
                snappingCurve: Curves.elasticOut,
                snappingDuration: Duration(milliseconds: 1000),
                grabbingContentOffset: GrabbingContentOffset.bottom,
              ),
            ],
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
              childScrollController: controller.scrollController,
              draggable: true,
              child: ChargerSheet(scrollController: controller.scrollController),
            ),
            child: MapSwitcher(
              child: PlatformMap(
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: snapshot.data ?? const LatLng(50, 50),
                  zoom: 15,
                ),
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
                mapType: MapType.normal,
                onMapCreated: (mapControl) {
                  controller.mapControler = mapControl;
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: Obx(() => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedScale(
                  scale: controller.sheetSize.value > 550 ? 0 : 1,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutQuint,
                  child: FloatingActionButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                    onPressed: () => Get.find<HomeController>().toggleDrawer(),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: const Icon(Icons.menu, color: Colors.white),
                  ),
                ),
                AnimatedScale(
                  scale: controller.sheetSize.value > 550 ? 0 : 1,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutQuint,
                  child: FloatingActionButton(
                    onPressed: () => controller.center(),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: const Icon(Icons.navigation, color: Colors.white),
                  ),
                ),
              ],
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      // bottomSheet: ChargerSheet(),
    );
  }
}
