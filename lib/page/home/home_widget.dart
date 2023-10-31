import 'package:flutter/material.dart';
import 'package:scraplink/widget/category_card.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: ListView(children: const [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CategoryCard(name: "toyota"),
            CategoryCard(name: "jeep"),
          ],
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CategoryCard(name: "honda"),
            CategoryCard(name: "ford"),
          ],
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CategoryCard(name: "hyundai"),
            CategoryCard(name: "kia"),
          ],
        ),
        SizedBox(height: 4),
        Divider(
          color: Colors.black,
        ),
      ]),
    );
  }
}
