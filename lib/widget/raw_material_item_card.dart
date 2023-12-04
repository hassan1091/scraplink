import 'package:flutter/material.dart';
import 'package:scraplink/api/api_service.dart';
import 'package:scraplink/api/model/raw_material.dart';
import 'package:scraplink/constants.dart';
import 'package:scraplink/my_theme.dart';
import 'package:scraplink/widget/scraps.dart';

class RawMaterialItemCard extends StatefulWidget {
  const RawMaterialItemCard({
    super.key,
    required this.rawMaterial,
    this.isInventory = false,
  });

  final RawMaterial rawMaterial;
  final bool isInventory;

  @override
  State<RawMaterialItemCard> createState() => _RawMaterialItemCardState();
}

class _RawMaterialItemCardState extends State<RawMaterialItemCard> {
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
              "https://xpfrdvwfquqhzzijsboi.supabase.co/storage/v1/object/public/raw_material/${widget.rawMaterial.type}.png",
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
                  widget.rawMaterial.type!,
                  style: MyTheme().titleStyle,
                ),
                Text(
                  widget.rawMaterial.description!,
                  style: MyTheme().subtitleStyle,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (widget.isInventory) {
                        ApiService()
                            .deleteScrapPart(widget.rawMaterial.id!)
                            .then((value) => context
                                .findAncestorStateOfType<State<ScrapsWidget>>()!
                                .setState(() {}));
                      } else {
                        Constants.contact(
                            widget.rawMaterial.fkVendorId.phoneNumber, context,
                            rawMaterial: widget.rawMaterial);
                      }
                    },
                    child: Text(
                      widget.isInventory ? "Delete" : "Buy Now",
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
