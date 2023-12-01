import 'package:flutter/material.dart';
import 'package:scraplink/api/api_service.dart';
import 'package:scraplink/api/model/car.dart';
import 'package:scraplink/widget/car_item_card.dart';

class AvailableCarPage extends StatefulWidget {
  const AvailableCarPage(
      {super.key, this.make, this.model, this.location, this.year});

  final String? make;
  final String? model;
  final String? location;
  final String? year;

  @override
  State<AvailableCarPage> createState() => _AvailableCarPageState();
}

class _AvailableCarPageState extends State<AvailableCarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Available Part ${widget.make}")),
      body: FutureBuilder(
        future: ApiService().getCars(
            isIndividual: false,
            make: widget.make,
            model: widget.model,
            location: widget.location,
            year: widget.year),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          List<Car> cars = snapshot.data!;

          return RefreshIndicator(
            onRefresh: () async => setState(() {}),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.75, crossAxisCount: 2),
                itemCount: cars.length,
                itemBuilder: (context, index) => CarItemCard(car: cars[index])),
          );
        },
      ),
    );
  }
}
