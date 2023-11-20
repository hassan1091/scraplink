import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scraplink/api/api_service.dart';
import 'package:scraplink/api/model/bid.dart';
import 'package:scraplink/api/model/car.dart';
import 'package:scraplink/my_theme.dart';

class CarDetailsPage extends StatelessWidget {
  const CarDetailsPage(this.car, {super.key});

  final Car car;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${car.model} ${car.year}")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            child: Image(
              image: NetworkImage(car.imageUrl!),
              fit: BoxFit.cover,
              width: double.maxFinite,
              height: 200,
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: MyTheme().titleStyle,
                  ),
                  Card(
                    elevation: 5,
                    margin:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                    child: TextField(
                      enabled: false,
                      maxLines: 3,
                      minLines: 3,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                      controller: TextEditingController(text: car.description!),
                    ),
                  ),
                ],
              ),
            ),
          ),
          FutureBuilder(
            future: ApiService().getBids(car.carId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              List<Bid> bids = snapshot.data!;

              return Expanded(
                child: GridView.builder(
                  itemCount: bids.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Change as needed
                    childAspectRatio: 1.5,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Expanded(
                          child: Column(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    bids[index].vendor!.name!,
                                    style: MyTheme().titleStyle,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "price: ${bids[index].price}",
                                    style: MyTheme().subtitleStyle,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        color: Colors.green,
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.check_circle_outline,
                                          size: 50,
                                        ),
                                      ),
                                      const SizedBox(width: 32),
                                      IconButton(
                                        color: Colors.red,
                                        onPressed: () {},
                                        icon: const Icon(
                                          CupertinoIcons.xmark_circle,
                                          size: 50,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildC() => Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Name: bidder1",
                    style: MyTheme().titleStyle, // Use your title style here
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "price: 1420",
                    style:
                        MyTheme().subtitleStyle, // Use your subtitle style here
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        color: Colors.green,
                        onPressed: () {},
                        icon: const Icon(
                          Icons.check_circle_outline,
                          size: 50,
                        ),
                      ),
                      const SizedBox(width: 32),
                      IconButton(
                        color: Colors.red,
                        onPressed: () {},
                        icon: const Icon(
                          CupertinoIcons.xmark_circle,
                          size: 50,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      );
}
