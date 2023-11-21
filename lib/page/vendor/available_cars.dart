import 'package:flutter/material.dart';
import 'package:scraplink/api/api_service.dart';
import 'package:scraplink/api/model/car.dart';
import 'package:scraplink/widget/car_item_card.dart';

class AvailableCarPage extends StatelessWidget {
  const AvailableCarPage(
      {super.key, this.make, this.model, this.location, this.year});

  final String? make;
  final String? model;
  final String? location;
  final String? year;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Available Part $make")),
      body: FutureBuilder(
        future: ApiService().getCars(
            isIndividual: false,
            make: make,
            model: model,
            location: location,
            year: year),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          List<Car> cars = snapshot.data!;

          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.75, crossAxisCount: 2),
              itemCount: cars.length,
              itemBuilder: (context, index) => CarItemCard(car: cars[index]));
        },
      ),
    );
  }
}
