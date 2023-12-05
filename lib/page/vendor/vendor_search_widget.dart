import 'package:flutter/material.dart';
import 'package:scraplink/constants.dart';
import 'package:scraplink/field_validation.dart';
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
  final TextEditingController _yearController = TextEditingController();
  String? _selectedMake;
  String? _selectedModel;
  String? _selectedLocation;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            MyDropdownButton(
              label: "Make:",
              hint: "Select a Make",
              items: Constants.models.keys.toList(),
              selectedItem: _selectedMake,
              onChanged: (s) {
                setState(() {
                  _selectedMake = s;
                });
              },
            ),
            const SizedBox(height: 16),
            MyDropdownButton(
              label: "Model:",
              hint: "Select a Model",
              items: Constants.models[_selectedMake] ?? [],
              selectedItem: _selectedModel,
              onChanged: (s) {
                setState(() {
                  _selectedModel = s;
                });
              },
            ),
            const SizedBox(height: 16),
            MyDropdownButton(
              label: "Location:",
              hint: "Select a Location",
              items: Constants.regions,
              selectedItem: _selectedLocation,
              onChanged: (s) {
                setState(() {
                  _selectedLocation = s;
                });
              },
            ),
            const SizedBox(height: 4),
            MyTextFormField(
              controller: _yearController,
              hint: "Year",
              lable: "Year",
              type: const TextInputType.numberWithOptions(),
              validator: FieldValidation.validateYear,
            ),
            const SizedBox(height: 4),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AvailableCarPage(
                                  make: _selectedMake,
                                  model: _selectedModel,
                                  location: _selectedLocation,
                                  year: _yearController.text,
                                )));
                  }
                },
                child: Text(
                  "Search",
                  style: MyTheme().buttonTextStyle,
                ))
          ],
        ),
      ),
    );
  }
}
