import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';
import 'package:snapping_sheet_2/snapping_sheet.dart';

class MainScreenController extends GetxController {
  final Completer<PlatformMapController> MapController = Completer<PlatformMapController>();
  final SnappingSheetController bottomController = SnappingSheetController();

  final ScrollController scrollController = ScrollController();
  final sheetSize = 0.0.obs;
}
