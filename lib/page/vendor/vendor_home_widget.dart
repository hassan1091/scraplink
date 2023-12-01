import 'package:flutter/material.dart';
import 'package:scraplink/api/api_service.dart';
import 'package:scraplink/api/model/car.dart';
import 'package:scraplink/my_theme.dart';
import 'package:scraplink/widget/car_item_card.dart';
import 'package:scraplink/widget/category_card.dart';

class VendorHomeWidget extends StatefulWidget {
  const VendorHomeWidget({super.key});

  @override
  State<VendorHomeWidget> createState() => _VendorHomeWidgetState();
}

class _VendorHomeWidgetState extends State<VendorHomeWidget> {
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
          "Latest salvage cars:",
          style: MyTheme().titleStyle,
        ),
        FutureBuilder(
          future: ApiService().getCars(isIndividual: false),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            List<Car> cars = snapshot.data!;

            return Expanded(
              child: RefreshIndicator(
                onRefresh: () async => setState(() {}),
                child: RefreshIndicator(
                  onRefresh: () async => setState(() {}),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.75, crossAxisCount: 2),
                    itemCount: cars.length,
                    itemBuilder: (context, index) =>
                        CarItemCard(car: cars[index]),
                  ),
                ),
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
