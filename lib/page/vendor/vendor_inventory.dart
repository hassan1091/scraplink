import 'package:flutter/material.dart';
import 'package:scraplink/my_theme.dart';
import 'package:scraplink/widget/scraps.dart';

class VendorInventoryPage extends StatelessWidget {
  const VendorInventoryPage(this.type, {super.key});

  final String type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Inventory of $type")),
      body: Column(
        children: [
          const SizedBox(height: 16),
          ElevatedButton(
              onPressed: () {},
              child: Text(
                "Add New",
                style: MyTheme().buttonTextStyle,
              )),
          const SizedBox(height: 16),
          const Expanded(
            child: ScrapsWidget(isInventory: true),
          ),
        ],
      ),
    );
  }
}
