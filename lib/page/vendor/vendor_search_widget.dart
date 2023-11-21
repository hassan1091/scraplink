import 'package:flutter/material.dart';
import 'package:scraplink/constants.dart';
import 'package:scraplink/my_theme.dart';
import 'package:scraplink/page/vendor/available_cars.dart';
import 'package:scraplink/widget/my_dropdown_button.dart';
import 'package:scraplink/widget/my_text_form_field.dart';

class VendorSearchPage extends StatefulWidget {
  const VendorSearchPage({super.key});

  @override
  State<StatefulWidget> createState() => SearchState();
}

class SearchState extends State<VendorSearchPage> {
  final TextEditingController yearController = TextEditingController();
  String? selectedMake;
  String? selectedCar;
  String? selectedModel;
  String? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          MyDropdownButton(
            label: "Make:",
            hint: "Select a Make",
            items: Constants.models.keys.toList(),
            selectedItem: selectedMake,
            onChanged: (s) {
              setState(() {
                selectedMake = s;
              });
            },
          ),
          const SizedBox(height: 16),
          MyDropdownButton(
            label: "Model:",
            hint: "Select a Model",
            items: Constants.models[selectedMake] ?? [],
            selectedItem: selectedModel,
            onChanged: (s) {
              setState(() {
                selectedModel = s;
              });
            },
          ),
          const SizedBox(height: 16),
          MyDropdownButton(
            label: "Location:",
            hint: "Select a Location",
            items: Constants.regions,
            selectedItem: selectedLocation,
            onChanged: (s) {
              setState(() {
                selectedLocation = s;
              });
            },
          ),
          const SizedBox(height: 4),
          MyTextFormField(
              controller: yearController,
              hint: "Year",
              lable: "Year",
              type: const TextInputType.numberWithOptions()),
          const SizedBox(height: 4),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AvailableCarPage(
                              make: selectedMake,
                              model: selectedModel,
                              location: selectedLocation,
                              year: yearController.text,
                            )));
              },
              child: Text(
                "Search",
                style: MyTheme().buttonTextStyle,
              ))
        ],
      ),
    );
  }
}
