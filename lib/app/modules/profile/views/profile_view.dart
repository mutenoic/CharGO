import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chargo/app/modules/home/controllers/home_controller.dart';
import 'package:chargo/app/services/profile_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(
      () => ProfileController(),
    );

    final drawerController = Get.find<HomeController>();
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Gas"),
          automaticallyImplyLeading: true,
          leading: IconButton(
            onPressed: () => drawerController.toggleDrawer(),
            icon: const Icon(Icons.menu),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 30.0, right: 30, top: 20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            profilePicture(),
            const SizedBox(
              height: 20,
            ),
            Form(
              autovalidateMode: AutovalidateMode.always,
              key: controller.formKey,
              child: Column(children: [
                profileTextField(
                  label: "Име",
                  controller: controller.displayNameController,
                  profileController: controller,
                ),
                const SizedBox(height: 15),
                profileTextField(
                  label: "Описание",
                  controller: controller.descriptionController,
                  profileController: controller,
                  canBeEmpty: true,
                ),
                const SizedBox(height: 15),
                profileTextField(
                  addedDecoration: const InputDecoration(prefixText: "+359"),
                  label: "Телефон",
                  type: TextInputType.phone,
                  controller: controller.phoneController,
                  profileController: controller,
                  canBeEmpty: true,
                  formatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(
                      9,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    )
                  ],
                ),
                const SizedBox(height: 15),
                profileTextField(
                  label: "Имейл",
                  controller: controller.emailController,
                  profileController: controller,
                  validator: (value) {
                    if (!value.isEmail) {
                      return "Невалиден имейл";
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 15),
                Obx(() {
                  switch (controller.role.value) {
                    case "teacher":
                      return controller.teacherSettings();

                    case "student":
                      return controller.studentSettings();

                    default:
                      return Container();
                  }
                }),
              ]),
            ),
            const SizedBox(
              height: 10,
            ),
            OutlinedButton(
              onPressed: () => controller.updateLocation(),
              child: const Text("Поднови локацията"),
            ),
            OutlinedButton(
              onPressed: () => controller.forgotPassword(),
              child: const Text("Промени паролата"),
            ),
            OutlinedButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.red),
                overlayColor: MaterialStatePropertyAll(Colors.red.withAlpha(20)),
              ),
              onPressed: () => controller.deleteProfile(),
              child: const Text("Изтрий профила"),
            ),
            SizedBox(height: Get.mediaQuery.padding.bottom),
          ]),
        ),
        floatingActionButton: Obx(
          () => FloatingActionButton(
            elevation: 3,
            onPressed: () => controller.saveSettings(),
            heroTag: "saveButton",
            child: const Icon(Icons.save),
          )
              .animate(
                target: controller.savedSettings.value ? 1 : 0,
              )
              .scaleXY(
                curve: Curves.easeOutCubic,
                duration: 400.ms,
                // delay: 150.ms,
                begin: -0.5,
                end: 1,
              )
              .slideY(
                end: 0,
                begin: 5,
                curve: Curves.easeOutCubic,
                duration: 400.ms,
              )
              .then()
              .blurXY(
                begin: 3,
                end: 0,
                duration: 350.ms,
                curve: Curves.easeOut,
              ),
        ),
      ),
    );
  }

  Widget profileTextField({
    required String label,
    required TextEditingController controller,
    required ProfileController profileController,
    InputDecoration addedDecoration = const InputDecoration(),
    TextInputType type = TextInputType.text,
    List<TextInputFormatter> formatters = const [],
    bool canBeEmpty = false,
    String? Function(String)? validator,
    int? maxLines,
    int? minLines,
  }) {
    return TextFormField(
      decoration: addedDecoration.copyWith(
        label: Text(label),
      ),
      inputFormatters: formatters,
      controller: controller,
      onChanged: (value) => profileController.setSavedSettings = true,
      keyboardType: type,
      validator: (value) {
        if (!canBeEmpty) {
          if (value == null || value.isEmpty) {
            return "Попъленете полето";
          }
        }

        if (validator != null) return validator(value ?? "");

        return null;
      },
      maxLines: maxLines,
      minLines: minLines,
    );
  }

  Widget profilePicture() {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.loose,
      clipBehavior: Clip.antiAlias,
      children: [
        Align(
          alignment: Alignment.center,
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
            builder: (context, snapshot) => FutureBuilder(
              future: ProfileService().getProfileInfo(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData || snapshot.hasError) {
                  return const CircularProgressIndicator();
                }

                return Obx(() {
                  if (controller.photo.value.path != "") {
                    return CircleAvatar(
                      radius: 100,
                      foregroundImage: FileImage(
                        File(controller.photo.value.path),
                      ),
                    );
                  }

                  var data = snapshot.data!;

                  Widget child = CircleAvatar(
                    radius: 100,
                    child: Text(
                      data["initials"] ?? "",
                      style: const TextStyle(fontSize: 60),
                    ),
                  );

                  if (data["photoUrl"]?.isNotEmpty ?? false) {
                    child = CircleAvatar(
                      radius: 100,
                      foregroundImage: CachedNetworkImageProvider(data["photoUrl"] ?? ""),
                    );
                  }

                  return child;
                });
              },
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(Get.context!).size.height / 4.5,
          width: 212,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(Get.context!).scaffoldBackgroundColor.withAlpha(100),
                borderRadius: BorderRadius.circular(360),
              ),
              child: IconButton(
                onPressed: () => controller.selectPhoto(),
                icon: const Icon(Icons.add_a_photo),
                iconSize: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
