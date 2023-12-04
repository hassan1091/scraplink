import 'package:flutter/material.dart';
import 'package:scraplink/api/model/car.dart';
import 'package:scraplink/my_theme.dart';
import 'package:scraplink/page/home/car_details.dart';

class CarItemCard extends StatelessWidget {
  const CarItemCard({
    super.key,
    required this.car,
  });

  final Car car;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16.0)),
            child: Image.network(
              car.imageUrl!,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${car.name} ${car.year}",
                  style: MyTheme().titleStyle,
                ),
                Text(
                  car.description!,
                  style: MyTheme().subtitleStyle,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CarDetailsPage(car, isVendor: true),
                        )),
                    child: Text(
                      "Buy Now",
                      style: MyTheme().buttonTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
