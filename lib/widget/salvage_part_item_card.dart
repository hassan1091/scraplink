import 'package:flutter/material.dart';
import 'package:scraplink/my_theme.dart';

class SalvagePartItemCard extends StatelessWidget {
  const SalvagePartItemCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.price,
    this.onPressed,
  });

  final String imageUrl;
  final String title;
  final String subtitle;
  final String buttonText;
  final double price;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16.0)),
            child: Image.network(
              imageUrl,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: MyTheme().titleStyle,
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: MyTheme().subtitleStyle,
                ),
                Text(
                  "Price: $price",
                  style: MyTheme().subtitleStyle,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: onPressed,
                    child: Text(
                      buttonText,
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