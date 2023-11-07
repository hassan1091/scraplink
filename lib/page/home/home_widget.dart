import 'package:flutter/material.dart';
import 'package:scraplink/my_theme.dart';
import 'package:scraplink/widget/category_card.dart';
import 'package:scraplink/widget/salvage_part_item_card.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Column(children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CategoryCard(name: "toyota"),
            CategoryCard(name: "jeep"),
          ],
        ),
        const SizedBox(height: 12),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CategoryCard(name: "honda"),
            CategoryCard(name: "ford"),
          ],
        ),
        const SizedBox(height: 12),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CategoryCard(name: "hyundai"),
            CategoryCard(name: "kia"),
          ],
        ),
        const SizedBox(height: 4),
        const Divider(
          color: Colors.black,
        ),
        Text(
          "Latest salvage parts:",
          style: MyTheme().titleStyle,
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.75, crossAxisCount: 2),
            itemCount: 6,
            itemBuilder: (context, index) => SalvagePartItemCard(
              imageUrl:
                  'https://m.media-amazon.com/images/I/71dZaqDPigL._AC_UF894,1000_QL80_.jpg',
              title: 'rim',
              subtitle: 'On car: Yaris',
              price: 200,
              buttonText: 'Buy Now',
              onPressed: () {},
            ),
          ),
        ),
        const SizedBox(
          height: 64,
        )
      ]),
    );
  }
}
