import 'package:flutter/material.dart';
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
      child: ListView(children: [
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
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SalvagePartItemCard(
          imageUrl:
              'https://m.media-amazon.com/images/I/71dZaqDPigL._AC_UF894,1000_QL80_.jpg',
          title: 'rim',
          subtitle: 'On car: Yaris',
          price: 200,
          buttonText: 'Buy Now',
          onPressed: () {},
        ),
        SalvagePartItemCard(
          imageUrl:
              'https://m.media-amazon.com/images/I/71dZaqDPigL._AC_UF894,1000_QL80_.jpg',
          title: 'Title',
          subtitle: 'Description or subtitle goes here.',
          price: 200,
          buttonText: 'Buy Now',
          onPressed: () {},
        ),
        const SizedBox(
          height: 64,
        )
      ]),
    );
  }
}
