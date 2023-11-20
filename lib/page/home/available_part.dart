import 'package:flutter/material.dart';
import 'package:scraplink/api/api_service.dart';
import 'package:scraplink/api/model/scrap_part.dart';
import 'package:scraplink/widget/salvage_part_item_card.dart';

class AvailablePartPage extends StatelessWidget {
  const AvailablePartPage({super.key, this.category});

  final String? category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Available Part $category")),
      body: FutureBuilder(
        future: ApiService().getScrapParts(make: category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          List<ScrapPart> parts = snapshot.data!;

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.75, crossAxisCount: 2),
            itemCount: parts.length,
            itemBuilder: (context, index) => SalvagePartItemCard(
              imageUrl: parts[index].imageUrl!,
              title: parts[index].name!,
              subtitle: parts[index].description!,
              price: parts[index].price!,
              buttonText: 'Buy Now',
              onPressed: () {},
            ),
          );
        },
      ),
    );
  }
}
