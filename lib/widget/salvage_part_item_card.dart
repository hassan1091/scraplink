import 'package:flutter/material.dart';
import 'package:scraplink/api/model/scrap_part.dart';
import 'package:scraplink/constants.dart';
import 'package:scraplink/my_theme.dart';

class SalvagePartItemCard extends StatelessWidget {
  const SalvagePartItemCard({
    super.key,
    required this.scrapPart,
    this.isInventory = false,
  });

  final ScrapPart scrapPart;
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
              scrapPart.imageUrl!,
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
                  scrapPart.name!,
                  style: MyTheme().titleStyle,
                ),
                Text(
                  scrapPart.description!,
                  style: MyTheme().subtitleStyle,
                ),
                Text(
                  "Price: ${scrapPart.price!}",
                  style: MyTheme().subtitleStyle,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (isInventory) {
                        return;
                      } else {
                        Constants.contact(
                            scrapPart.vendor!.phoneNumber, context,
                            scrapPart: scrapPart);
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
