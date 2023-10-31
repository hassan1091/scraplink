import 'package:flutter/material.dart';
import 'package:scraplink/widget/category_card.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(children: const [
      SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CategoryCard(name: "toyota"),
          CategoryCard(name: "jeep"),
        ],
      ),
      SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CategoryCard(name: "honda"),
          CategoryCard(name: "ford"),
        ],
      ),
      SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CategoryCard(name: "hyundai"),
          CategoryCard(name: "kia"),
        ],
      ),
      SizedBox(height: 4),
      Divider(
        color: Colors.black,
      ),
    ]);
  }
}
