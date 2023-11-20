import 'package:flutter/material.dart';
import 'package:scraplink/constants.dart';
import 'package:scraplink/my_theme.dart';
import 'package:scraplink/widget/yard_card.dart';
import 'package:url_launcher/url_launcher.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  String? selectedLocation;

  void _contact(phoneNumber) {
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
            Text(
              "City:",
              style: MyTheme().titleStyle,
            ),
            DropdownButton(
              value: selectedLocation,
              hint: Text(
                "Select a Location",
                style: MyTheme().subtitleStyle,
              ),
              items: Constants.regions.map((String item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: MyTheme().subtitleStyle,
                  ),
                );
              }).toList(),
              onChanged: (s) {
                setState(() {
                  selectedLocation = s;
                });
              },
              icon: const Icon(Icons.arrow_drop_down),
            ),
          ],
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            children: [
              YardCard(
                name: "scrap 1",
                city: "Al-damam",
                onPressed: () => _contact("+966502130371"),
              ),
              YardCard(
                  name: "scrap 2",
                  city: "mam",
                  onPressed: () => _contact("+9665021371")),
              YardCard(
                  name: "scrap 3",
                  city: "mam",
                  onPressed: () => _contact("+9665021371")),
              YardCard(
                  name: "scrap 4",
                  city: "mam",
                  onPressed: () => _contact("+9665021371")),
              YardCard(
                  name: "scrap 55",
                  city: "mam",
                  onPressed: () => _contact("+9665021371")),
            ],
          ),
        )
      ],
    );
  }
}
