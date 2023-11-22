import 'package:flutter/material.dart';
import 'package:scraplink/my_theme.dart';
import 'package:scraplink/page/vendor/sell_Part.dart';
import 'package:scraplink/widget/cars.dart';
import 'package:scraplink/widget/materials.dart';
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
          if (type != "Cars") ...[
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () {
                  if (type == "Parts") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SellPartPage()));
                  }
                },
                child: Text(
                  "Add New",
                  style: MyTheme().buttonTextStyle,
                ))
          ],
          const SizedBox(height: 16),
          Expanded(
            child: type == "Parts"
                ? const ScrapsWidget(isInventory: true)
                : type == "Cars"
                    ? const CarsWidget()
                    : const MaterialsWidget(isInventory: true),
          ),
        ],
      ),
    );
  }
}
