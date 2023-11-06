import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scraplink/my_theme.dart';

class CarDetailsPage extends StatelessWidget {
  const CarDetailsPage({super.key});

  Card buildCard() {
    var heading = '\$2300 per month';
    var subheading = '2 bed, 1 bath, 1300 sqft';
    var cardImage =
        const NetworkImage('https://source.unsplash.com/random/800x600?house');
    var supportingText =
        'Beautiful home to rent, recently refurbished with modern appliances...';
    return Card(
        elevation: 4.0,
        child: Column(
          children: [
            ListTile(
              title: Text(heading),
              subtitle: Text(subheading),
              trailing: const Icon(Icons.favorite_outline),
            ),
            SizedBox(
              height: 200.0,
              child: Ink.image(
                image: cardImage,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.centerLeft,
              child: Text(supportingText),
            ),
            ButtonBar(
              children: [
                TextButton(
                  child: const Text('CONTACT AGENT'),
                  onPressed: () {
                    /* ... */
                  },
                ),
                TextButton(
                  child: const Text('LEARN MORE'),
                  onPressed: () {
                    /* ... */
                  },
                )
              ],
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Camry 2013")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SingleChildScrollView(
            child: Image(
              image: NetworkImage(
                  "https://www.copart.com/content/us/en/images/landing-pages/FrontEnd.jpg"),
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
                      controller: TextEditingController(
                          text: "The car has scratches on the front bumper"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Change as needed
                childAspectRatio: MediaQuery.of(context).size.width /
                    ((MediaQuery.of(context).size.height + 100) / 4),
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
                                "Name: bidder1",
                                style: MyTheme()
                                    .titleStyle, // Use your title style here
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                "price: 1420",
                                style: MyTheme()
                                    .subtitleStyle, // Use your subtitle style here
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
