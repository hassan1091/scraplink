import 'package:flutter/material.dart';
import 'package:scraplink/api/api_service.dart';
import 'package:scraplink/api/model/scrap_part.dart';
import 'package:scraplink/constants.dart';
import 'package:scraplink/my_theme.dart';
import 'package:scraplink/widget/scraps.dart';

class SalvagePartItemCard extends StatefulWidget {
  const SalvagePartItemCard({
    super.key,
    required this.scrapPart,
    this.isInventory = false,
  });

  final ScrapPart scrapPart;
  final bool isInventory;

  @override
  State<SalvagePartItemCard> createState() => _SalvagePartItemCardState();
}

class _SalvagePartItemCardState extends State<SalvagePartItemCard> {
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
              widget.scrapPart.imageUrl!,
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
                  widget.scrapPart.name!,
                  style: MyTheme().titleStyle,
                ),
                Text(
                  widget.scrapPart.description!,
                  style: MyTheme().subtitleStyle,
                ),
                Text(
                  "Price: ${widget.scrapPart.price!}",
                  style: MyTheme().subtitleStyle,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (widget.isInventory) {
                        ApiService().deleteScrapPart(widget.scrapPart.id!).then(
                            (value) => context
                                .findAncestorStateOfType<State<ScrapsWidget>>()!
                                .setState(() {}));
                      } else {
                        Constants.contact(
                            widget.scrapPart.vendor!.phoneNumber, context,
                            scrapPart: widget.scrapPart);
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
