import 'package:flutter/material.dart';
import 'package:scraplink/api/api_service.dart';
import 'package:scraplink/api/model/raw_material.dart';
import 'package:scraplink/constants.dart';
import 'package:scraplink/my_theme.dart';
import 'package:scraplink/widget/raw_material_item_card.dart';

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
        FutureBuilder(
          future: ApiService().getRawMaterial(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            List<RawMaterial> materials = snapshot.data!;
            if (selectedLocation != null) {
              materials = materials
                  .where((element) =>
                      element.fkVendorId.location == selectedLocation)
                  .toList();
            }
            if (selectedType != null) {
              materials = materials
                  .where((element) => element.type == selectedType)
                  .toList();
            }
            return Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: materials.length,
                itemBuilder: (context, index) =>
                    RawMaterialItemCard(rawMaterial: materials[index]),
              ),
            );
          },
        )
      ],
    );
  }
}
