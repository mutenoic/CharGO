import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:inner_drawer/inner_drawer.dart';

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
      borderRadius: 20, // default 0
      leftAnimationType: InnerDrawerAnimation.quadratic,
      backgroundDecoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      rightChild: Container(
        color: Colors.transparent,
        child: Material(
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "CharGO",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Column(
                  children: [
                    ListTile(
                      selected: true,
                      title: const Text("Hello world"),
                      onTap: () {},
                    ),
                    ListTile(
                      selected: false,
                      title: const Text("Hello world"),
                      onTap: () {},
                    ),
                    ListTile(
                      selected: false,
                      title: const Text("Hello world"),
                      onTap: () {},
                    ),
                    ListTile(
                      selected: false,
                      title: const Text("Hello world"),
                      onTap: () {},
                    )
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
        ),
      ),

      scaffold: MainScreen(controller: controller),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => controller.toggleDrawer(),
          icon: const Icon(Icons.menu),
        ),
      ),
      body: const Center(
        child: Text(
          'HomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
