import 'package:flutter/material.dart';
import 'package:scraplink/api/api_service.dart';
import 'package:scraplink/api/model/scrap_part.dart';
import 'package:scraplink/constants.dart';
import 'package:scraplink/my_theme.dart';
import 'package:scraplink/widget/category_card.dart';
import 'package:scraplink/widget/salvage_part_item_card.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Column(children: [
        SizedBox(
          height: 150,
          child: ListView.builder(
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: CategoryCard(name: Constants.models.keys.toList()[index]),
            ),
            itemCount: Constants.models.keys.toList().length,
            scrollDirection: Axis.horizontal,
          ),
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
              child: RefreshIndicator(
                onRefresh: () async => setState(() {}),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.75, crossAxisCount: 2),
                  itemCount: parts.length,
                  itemBuilder: (context, index) =>
                      SalvagePartItemCard(scrapPart: parts[index]),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 64)
      ]),
    );
  }
}
