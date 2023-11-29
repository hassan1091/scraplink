import 'package:flutter/material.dart';
import 'package:scraplink/api/model/raw_material.dart';
import 'package:scraplink/constants.dart';
import 'package:scraplink/my_theme.dart';

class RawMaterialItemCard extends StatelessWidget {
  const RawMaterialItemCard({
    super.key,
    required this.rawMaterial,
    this.isInventory = false,
  });

  final RawMaterial rawMaterial;
  final bool isInventory;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16.0)),
            child: Image.network(
              "https://xpfrdvwfquqhzzijsboi.supabase.co/storage/v1/object/public/raw_material/${rawMaterial.type}.png",
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  rawMaterial.type!,
                  style: MyTheme().titleStyle,
                ),
                Text(
                  rawMaterial.description!,
                  style: MyTheme().subtitleStyle,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (!isInventory) {
                        Constants.contact(
                            rawMaterial.fkVendorId.phoneNumber, context,
                            rawMaterial: rawMaterial);
                      }
                    },
                    child: Text(
                      isInventory ? "Delete" : "Buy Now",
                      style: MyTheme().buttonTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
