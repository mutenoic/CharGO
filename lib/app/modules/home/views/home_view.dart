import 'dart:async';

import 'package:chargo/app/modules/home/views/drawer_content.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:inner_drawer/inner_drawer.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomeController());
    return InnerDrawer(
      key: controller.innerDrawerKey,
      onTapClose: true, // default false
      colorTransitionChild: Theme.of(context).colorScheme.surface, // default Color.black54
      colorTransitionScaffold: Colors.transparent, // default Color.black54

      boxShadow: const [
        BoxShadow(
          offset: Offset(0, 15),
          color: Colors.black26,
          blurRadius: 30,
          spreadRadius: 10,
        )
      ],

      velocity: 0.6,

      offset: const IDOffset.only(left: 0.5),
      scale: const IDOffset.horizontal(0.8), // set the offset in both directions
      proportionalChildArea: false, // default true
      borderRadius: 50, // default 0
      leftAnimationType: InnerDrawerAnimation.linear,
      swipe: false,
      backgroundDecoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      leftChild: const DrawerContent(),
      scaffold: MainScreen(controller: controller),
    );
  }
}

class MainScreen extends StatelessWidget {
  MainScreen({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  final Completer<PlatformMapController> _controller = Completer<PlatformMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        leading: IconButton.filled(
          onPressed: () => controller.toggleDrawer(),
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
      ),
      body: PlatformMap(
        markers: <Marker>{
          Marker(
            markerId: MarkerId('marker_1'),
            position: const LatLng(47.6, 8.8796),
            consumeTapEvents: true,
            infoWindow: const InfoWindow(
              title: 'PlatformMarker',
              snippet: "Hi I'm a Platform Marker",
            ),
            onTap: () {
              print("Marker tapped");
            },
          ),
        },
        compassEnabled: false,
        myLocationButtonEnabled: false,
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (PlatformMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final PlatformMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
