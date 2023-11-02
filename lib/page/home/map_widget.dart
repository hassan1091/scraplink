import 'package:flutter/material.dart';
import 'package:scraplink/widget/yard_card.dart';
import 'package:url_launcher/url_launcher.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  String? selectedCity;

  void contact(phoneNumber) {
    Uri url = Uri.parse("https://wa.me/$phoneNumber");
    launchUrl(url, mode: LaunchMode.externalApplication).then((value) {
      if (!value) {
        showDialog(
            context: context,
            builder: (_) => const AlertDialog(
                title: Text(
                    "Could not launch WhatsApp. Make sure WhatsApp is installed on your device.")));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text("City:"),
            DropdownButton(
              value: selectedCity,
              hint: const Text('Select a City'),
              items: const [
                DropdownMenuItem(
                  value: "All",
                  child: Text("All"),
                ),
                DropdownMenuItem(
                  value: "Al-hasa",
                  child: Text("Al-hasa"),
                ),
                DropdownMenuItem(value: "Al-damam", child: Text("Al-damam"))
              ],
              onChanged: (s) {
                setState(() {
                  selectedCity = s;
                });
              },
              icon: const Icon(Icons.arrow_drop_down),
            )
          ],
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            children: [
              YardCard(
                name: "scrap 1",
                city: "Al-damam",
                onPressed: () => contact("+966502130371"),
              ),
              YardCard(
                  name: "scrap 2",
                  city: "mam",
                  onPressed: () => contact("+9665021371")),
              YardCard(
                  name: "scrap 3",
                  city: "mam",
                  onPressed: () => contact("+9665021371")),
              YardCard(
                  name: "scrap 4",
                  city: "mam",
                  onPressed: () => contact("+9665021371")),
              YardCard(
                  name: "scrap 55",
                  city: "mam",
                  onPressed: () => contact("+9665021371")),
            ],
          ),
        )
      ],
    );
  }
}
