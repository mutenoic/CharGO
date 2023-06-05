import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snapping_sheet_2/snapping_sheet.dart';

class MainScreenController extends GetxController {
  final Completer<GoogleMapController> MapController = Completer<GoogleMapController>();
  final SnappingSheetController bottomController = SnappingSheetController();

  final ScrollController scrollController = ScrollController();
  final sheetSize = 0.0.obs;
}
