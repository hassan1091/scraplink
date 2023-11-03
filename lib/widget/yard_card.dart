import 'package:flutter/material.dart';
import 'package:scraplink/my_theme.dart';

class YardCard extends StatelessWidget {
  const YardCard({
    super.key,
    required this.name,
    required this.city,
    this.onPressed,
  });

  final String name;
  final String city;
  final VoidCallback? onPressed;

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
                  "Name: $name",
                  style: MyTheme().titleStyle,
                ),
                Text(
                  "City: $city",
                  style: MyTheme().subtitleStyle,
                ),
                ElevatedButton(
                  onPressed: onPressed,
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
