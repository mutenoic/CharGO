import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => RegisterController());
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Регистрация",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              expandedTitleScale: 1.5,
              centerTitle: true,
              collapseMode: CollapseMode.parallax,
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text("Емайл"),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () => TextFormField(
                        decoration: InputDecoration(
                          label: const Text("Парола"),
                          suffixIcon: IconButton(
                            onPressed: () => controller.showPassword.value = !controller.showPassword.value,
                            icon: const Icon(Icons.remove_red_eye),
                          ),
                        ),
                        obscureText: !controller.showPassword.value,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () => TextFormField(
                        decoration: InputDecoration(
                          label: const Text("Потвърди парола"),
                          suffixIcon: IconButton(
                            onPressed: () => controller.showPassword.value = !controller.showPassword.value,
                            icon: const Icon(Icons.remove_red_eye),
                          ),
                        ),
                        obscureText: !controller.showPassword.value,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text("Име"),
                      ),
                    ),
                    DropdownButtonFormField(
                      enableFeedback: true,
                      items: const <DropdownMenuItem<String>>[
                        DropdownMenuItem(
                          value: "SFA",
                          child: Text("SD"),
                        ),
                        DropdownMenuItem(
                          value: "SFA",
                          child: Text("SD"),
                        ),
                        DropdownMenuItem(
                          value: "SFA",
                          child: Text("SD"),
                        ),
                        DropdownMenuItem(
                          value: "SFA",
                          child: Text("SD"),
                        ),
                        DropdownMenuItem(
                          value: "SFA",
                          child: Text("SD"),
                        ),
                      ],
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () => controller.createAccount(),
                      icon: const Icon(Icons.app_registration_rounded),
                      label: const Text("Регистриране"),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: Get.mediaQuery.padding.bottom,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
