import 'dart:async';

import 'package:chargo/app/services/geo_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

class MapController extends GetxController {
  late PlatformMapController mapControler;

  final ScrollController scrollController = ScrollController();

  final SnappingSheetController bottomController = SnappingSheetController();

  final sheetSize = 0.0.obs;

  Future<void> center() async {
    var location = await GeoService.getLocation();
    mapControler.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: location,
          zoom: 15,
        ),
      ),
    );
  }
}
