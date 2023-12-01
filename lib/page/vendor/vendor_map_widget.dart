import 'package:flutter/material.dart';
import 'package:scraplink/api/api_service.dart';
import 'package:scraplink/api/model/user_profile.dart';
import 'package:scraplink/constants.dart';
import 'package:scraplink/my_theme.dart';
import 'package:scraplink/widget/yard_card.dart';

class VendorMapWidget extends StatefulWidget {
  const VendorMapWidget({super.key});

  @override
  State<VendorMapWidget> createState() => _VendorMapWidgetState();
}

class _VendorMapWidgetState extends State<VendorMapWidget> {
  String? selectedLocation;

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
          future: ApiService().getRecycleCompanies(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            List<UserProfile> companies = snapshot.data!;
            if (selectedLocation != null) {
              companies = companies
                  .where((element) => element.location == selectedLocation)
                  .toList();
            }
            return Expanded(
              child: RefreshIndicator(
                onRefresh: () async => setState(() {}),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: companies.length,
                  itemBuilder: (context, index) =>
                      YardCard(vendor: companies[index]),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
