import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => RegisterController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('RegisterView'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Obx(
            () => Stepper(
              onStepTapped: (value) => controller.currentStep.value = value,
              onStepContinue: () => controller.currentStep.value++,
              steps: [
                Step(
                  title: const Text("HEllo"),
                  content: const Text("dfasd"),
                  isActive: controller.currentStep.value == 0,
                  state: controller.currentStep.value > 0 ? StepState.complete : StepState.indexed,
                ),
                Step(
                  title: const Text("HEllo"),
                  content: const Text("dfasd"),
                  isActive: controller.currentStep.value == 1,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
