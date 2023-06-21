import 'package:chargo/app/modules/home/controllers/home_controller.dart';
import 'package:chargo/app/services/payment_service.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_credits_controller.dart';

class AddCreditsView extends GetView<AddCreditsController> {
  const AddCreditsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AddCreditsController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Портфейл'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Get.find<HomeController>().toggleDrawer(),
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.info))],
      ),
      body: Form(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // TODO: ADD ICON
                Row(
                  children: [
                    Image.asset(
                      "lib/assets/token.png",
                      width: 50,
                    ),
                    Text("= 0.62", style: Theme.of(context).textTheme.headlineSmall),
                  ],
                ),
                Container(
                  color: Colors.black,
                  width: 2,
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                ),
                Row(
                  children: [
                    Image.asset(
                      "lib/assets/token.png",
                      width: 50,
                    ),
                    Text("= 1 лв", style: Theme.of(context).textTheme.headlineSmall),
                  ],
                )
              ],
            ),
            const Divider(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(label: Text("Сума")),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null) return "Попълнете полето";

                        var num = int.tryParse(value);
                        if (num == null) return "Невалидно число";

                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  FilledButton(onPressed: () {}, child: const Text("Зареди"))
                ],
              ),
            ),
            Expanded(
              child: GridView(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 190),
                children: [
                  for (var i in [5, 10, 15, 20, 50, 100])
                    Card(
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        enableFeedback: true,
                        onTap: () {
                          print(i + 0.0);
                          PaymentService().makePayment(
                              amount: i.toDouble(),
                              currency: "BGN",
                              cardNumber: 4242424242424242,
                              expirationMonth: 07,
                              expirationYear: 2024,
                              cvc: 233);
                        },
                        child: Center(
                          child: Text(i.toString()),
                        ),
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
