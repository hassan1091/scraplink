import 'package:flutter/material.dart';
import 'package:scraplink/api/api_service.dart';
import 'package:scraplink/api/model/scrap_part.dart';

import 'salvage_part_item_card.dart';

class ScrapsWidget extends StatelessWidget {
  const ScrapsWidget({
    super.key,
    this.make,
    this.model,
    this.category,
    this.year,
    this.isInventory = false,
  });

  final String? make;
  final String? model;
  final String? category;
  final String? year;
  final bool isInventory;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiService().getScrapParts(
          isInventory: isInventory,
          make: make,
          model: model,
          category: category,
          year: year),
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
                scrapPart: parts[index], isInventory: isInventory));
      },
    );
  }
}
