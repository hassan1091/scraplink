import 'package:flutter/material.dart';
import 'package:scraplink/widget/salvage_part_item_card.dart';

class AvailablePartPage extends StatelessWidget {
  const AvailablePartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Available Part")),
      body: GridView.builder(
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
    );
  }
}
