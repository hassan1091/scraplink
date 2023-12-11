import 'package:flutter/material.dart';
import 'package:scraplink/api/api_service.dart';
import 'package:scraplink/api/model/bid.dart';
import 'package:scraplink/api/model/car.dart';
import 'package:scraplink/my_theme.dart';

class CarsWidget extends StatefulWidget {
  const CarsWidget({
    super.key,
    this.car,
  });

  final Car? car;

  @override
  State<CarsWidget> createState() => _CarsWidgetState();
}

class _CarsWidgetState extends State<CarsWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiService().getBids(widget.car?.carId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        List<Bid> bids = snapshot.data!;

        return Expanded(
          child: RefreshIndicator(
            onRefresh: () async => setState(() {}),
            child: GridView.builder(
              itemCount: bids.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Change as needed
                childAspectRatio: widget.car?.carId == null ? 0.9 : 1.25,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          if (widget.car?.carId != null)
                            Text(
                              bids[index].vendor!.name!,
                              style: MyTheme().titleStyle,
                            )
                          else
                            Image.network(
                              bids[index].carId.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          const SizedBox(height: 4),
                          Text(
                            "price: ${bids[index].price}",
                            style: MyTheme().subtitleStyle,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                "status: ",
                                style: MyTheme().subtitleStyle,
                              ),
                              Text(
                                "${bids[index].status}",
                                style: TextStyle(
                                    color: bids[index].status ==
                                            BidStatus.accepted.name
                                        ? Colors.green
                                        : bids[index].status ==
                                                BidStatus.rejected.name
                                            ? Colors.red
                                            : Colors.grey,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          if (bids[index].status == BidStatus.accepted.name)
                            ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  "Contact",
                                  style: MyTheme().buttonTextStyle,
                                ))
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
