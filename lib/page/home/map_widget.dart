import 'package:flutter/material.dart';
import 'package:scraplink/api/api_service.dart';
import 'package:scraplink/api/model/vendor.dart';
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
              "Location:",
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
        FutureBuilder(
          future: ApiService().getVendors(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            List<Vendor> vendors = snapshot.data!;
            if (selectedLocation != null) {
              vendors = vendors
                  .where((element) => element.city == selectedLocation)
                  .toList();
            }
            return Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: vendors.length,
                itemBuilder: (context, index) {
                  return YardCard(
                    name: vendors[index].name!,
                    city: vendors[index].city!,
                    onPressed: () => _contact(vendors[index].phoneNumber!),
                  );
                },
              ),
            );
          },
        )
      ],
    );
  }
}
