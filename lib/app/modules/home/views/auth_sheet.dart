import 'package:cached_network_image/cached_network_image.dart';
import 'package:chargo/app/modules/login/views/login_view.dart';
import 'package:chargo/app/modules/register/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthSheet extends StatelessWidget {
  const AuthSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) => Container(
        height: 450,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: SafeArea(
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: "https://img.icons8.com/?size=512&id=64388&format=png",
                width: 100,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Направи зареждането лесно",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Създай си акаунт с който ще имаш достъп до всички функционалности и ще можеш да резервираш зарядни",
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              Expanded(child: Container()),
              FilledButton(
                style: ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(
                    Size(MediaQuery.of(context).size.width - 50, 60),
                  ),
                ),
                onPressed: () {
                  Get.back();
                  Get.to(() => const RegisterView());
                },
                child: const Text("Направи си акаунт", style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Имаш акаунт?", style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18)),
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: () {
                      Get.back();
                      Get.to(() => const LoginView());
                    },
                    child: const Text(
                      "Влез",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
