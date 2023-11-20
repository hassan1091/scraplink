import 'package:flutter/material.dart';
import 'package:scraplink/api/api_service.dart';
import 'package:scraplink/api/model/scrap_part.dart';
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
            CategoryCard(name: "Toyota"),
            CategoryCard(name: "Jeep"),
          ],
        ),
        const SizedBox(height: 12),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CategoryCard(name: "Honda"),
            CategoryCard(name: "Ford"),
          ],
        ),
        const SizedBox(height: 12),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CategoryCard(name: "Hyundai"),
            CategoryCard(name: "Kia"),
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
        FutureBuilder(
          future: ApiService().getScrapParts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            List<ScrapPart> parts = snapshot.data!;

            return Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.75, crossAxisCount: 2),
                itemCount: parts.length,
                itemBuilder: (context, index) =>
                    SalvagePartItemCard(scrapPart: parts[index]),
              ),
            );
          },
        ),
        const SizedBox(
          height: 64,
        )
      ]),
    );
  }
}
