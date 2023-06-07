import 'package:chargo/models/charger.dart';
import 'package:flutter/material.dart';

class ChargerTile extends StatelessWidget {
  ChargerTile({super.key, required this.charger});

  final Charger charger;

  final Map<String, AssetImage> plugs = {
    "0": const AssetImage("lib/assets/caravan-mains.png"),
    "1": const AssetImage("lib/assets/ccs-type2.png"),
    "2": const AssetImage("lib/assets/chademo.png"),
    "3": const AssetImage("lib/assets/gbt2.png"),
    "4": const AssetImage("lib/assets/roadster.png"),
    "5": const AssetImage("lib/assets/tesla.png"),
    "6": const AssetImage("lib/assets/three-phase-eu.png"),
    "7": const AssetImage("lib/assets/type2.png"),
    "8": const AssetImage("lib/assets/wall-eu.png"),
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("asd");
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 75,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 5, offset: Offset.zero),
          ],
        ),
        child: Row(
          children: [
            Image(
              image: plugs["5"] ?? const AssetImage(""),
              alignment: Alignment.center,
            ),
            const SizedBox(width: 30),
            Column(
              children: [
                Text(
                  charger.name,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  charger.description,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            Expanded(child: Container()),
            Text(charger.type),
          ],
        ),
      ),
    );
  }
}
