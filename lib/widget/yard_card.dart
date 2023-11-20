import 'package:flutter/material.dart';
import 'package:scraplink/api/model/vendor.dart';
import 'package:scraplink/constants.dart';
import 'package:scraplink/my_theme.dart';

class YardCard extends StatelessWidget {
  const YardCard({
    super.key,
    required this.vendor,
  });

  final Vendor vendor;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16.0)),
            child: Image.network(
              "https://static.thenounproject.com/png/46960-200.png",
              height: 100,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Name: ${vendor.name}",
                  style: MyTheme().titleStyle,
                ),
                Text(
                  "City: ${vendor.location}",
                  style: MyTheme().subtitleStyle,
                ),
                ElevatedButton(
                  onPressed: () =>
                      Constants.contact(vendor.phoneNumber, context),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.green)),
                  child: const Row(
                    children: [
                      Image(
                        height: 25,
                        width: 25,
                        color: Colors.white,
                        image: AssetImage("assets/icons/whatsapp.png"),
                      ),
                      // SizedBox(width: 4),
                      Text(
                        "Contact",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
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
