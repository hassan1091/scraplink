import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scraplink/api/api_service.dart';
import 'package:scraplink/api/model/bid.dart';
import 'package:scraplink/api/model/car.dart';
import 'package:scraplink/constants.dart';
import 'package:scraplink/field_validation.dart';
import 'package:scraplink/my_theme.dart';
import 'package:scraplink/shared_preferences.dart';
import 'package:scraplink/widget/loading_indicator_dialog.dart';
import 'package:scraplink/widget/my_text_form_field.dart';

class CarDetailsPage extends StatefulWidget {
  const CarDetailsPage(this.car, {super.key, this.isVendor = false});

  final Car car;
  final bool isVendor;

  @override
  State<CarDetailsPage> createState() => _CarDetailsPageState();
}

class _CarDetailsPageState extends State<CarDetailsPage> {
  final TextEditingController bidController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late final num vendorId;

  @override
  void initState() {
    AppLocalStorage.getString(AppStorageKey.id)
        .then((value) => vendorId = num.parse(value!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.car.model} ${widget.car.year}")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            child: Image(
              image: NetworkImage(widget.car.imageUrl!),
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
                      controller:
                          TextEditingController(text: widget.car.description!),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (widget.isVendor) ...[
            Padding(
              padding: const EdgeInsets.all(8),
              child: Form(
                key: _formKey,
                child: MyTextFormField(
                  lable: "bid",
                  hint: "Enter your bid",
                  type: TextInputType.number,
                  icon: Image.asset("assets/icons/bid.png"),
                  controller: bidController,
                  validator: FieldValidation.validateRequired,
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      LoadingIndicatorDialog().show(context);
                      await ApiService().bid(Bid(
                          carId: widget.car.carId,
                          price: num.parse(bidController.text)));
                      LoadingIndicatorDialog().dismiss();
                      setState(() {});
                    }
                  },
                ),
              ),
            )
          ],
          FutureBuilder(
            future: ApiService().getBids(widget.car.carId),
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Change as needed
                      childAspectRatio: 1.5,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      if (!widget.isVendor) {
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      if (bids[index].status ==
                                          BidStatus.pending.name)
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              color: Colors.green,
                                              onPressed: () =>
                                                  _accept(bids[index]),
                                              icon: const Icon(
                                                Icons.check_circle_outline,
                                                size: 50,
                                              ),
                                            ),
                                            const SizedBox(width: 32),
                                            IconButton(
                                              color: Colors.red,
                                              onPressed: () =>
                                                  _reject(bids[index]),
                                              icon: const Icon(
                                                CupertinoIcons.xmark_circle,
                                                size: 50,
                                              ),
                                            ),
                                          ],
                                        )
                                      else ...[
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            if (bids[index].status ==
                                                BidStatus.accepted.name)
                                              IconButton(
                                                onPressed: () =>
                                                    _sendAccepted(bids[index]),
                                                icon: const Icon(
                                                  Icons.reply,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            Text(
                                                bids[index]
                                                    .status!
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                  color: bids[index].status ==
                                                          BidStatus
                                                              .accepted.name
                                                      ? Colors.green
                                                      : Colors.red,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ],
                                        ),
                                      ]
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          if (bids[index].status ==
                                              BidStatus.accepted.name)
                                            IconButton(
                                              onPressed: () =>
                                                  _sendAccepted(bids[index]),
                                              icon: const Icon(
                                                Icons.reply,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          Text(
                                              bids[index].status!.toUpperCase(),
                                              style: TextStyle(
                                                color: bids[index].status ==
                                                        BidStatus.accepted.name
                                                    ? Colors.green
                                                    : bids[index].status ==
                                                            BidStatus
                                                                .rejected.name
                                                        ? Colors.red
                                                        : Colors.grey,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              ))
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _reject(Bid bid) async {
    await ApiService()
        .reject(bid)
        .then((_) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => CarDetailsPage(widget.car))))
        .onError((error, stackTrace) => showDialog(
              context: context,
              builder: (context) =>
                  const AlertDialog(title: Text("Failed to reject. Try again")),
            ));
  }

  void _accept(Bid bid) async {
    await ApiService().accept(bid).then((_) {
      _sendAccepted(bid);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => CarDetailsPage(widget.car)));
    }).onError((error, stackTrace) => showDialog(
          context: context,
          builder: (context) =>
              const AlertDialog(title: Text("Failed to accept. Try again")),
        ));
  }

  Future<void> _sendAccepted(Bid bid) async {
    if (!widget.isVendor) {
      Constants.contact(bid.vendor!.phoneNumber, context,
          bid: bid, car: widget.car);
    } else {
      Constants.contact(
          await ApiService().getCarOwnerPhone(widget.car.carId), context,
          bid: bid, car: widget.car, isBid: true);
    }
  }
}
