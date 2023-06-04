import 'package:flutter/material.dart';

class DrawerContent extends StatelessWidget {
  const DrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
