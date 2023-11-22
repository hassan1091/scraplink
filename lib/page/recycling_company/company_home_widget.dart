import 'package:flutter/material.dart';
import 'package:scraplink/constants.dart';
import 'package:scraplink/my_theme.dart';
import 'package:scraplink/widget/materials.dart';

class CompanyHomeWidget extends StatefulWidget {
  const CompanyHomeWidget({
    super.key,
  });

  @override
  State<CompanyHomeWidget> createState() => _CompanyHomeWidgetState();
}

class _CompanyHomeWidgetState extends State<CompanyHomeWidget> {
  String? selectedLocation;
  String? selectedType;

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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Material Type:",
              style: MyTheme().titleStyle,
            ),
            DropdownButton(
              value: selectedType,
              hint: Text(
                "Select a Material Type",
                style: MyTheme().subtitleStyle,
              ),
              items: Constants.materialTypes.map((String item) {
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
                  selectedType = s;
                });
              },
              icon: const Icon(Icons.arrow_drop_down),
            ),
          ],
        ),
        MaterialsWidget(
            selectedLocation: selectedLocation, selectedType: selectedType)
      ],
    );
  }
}
