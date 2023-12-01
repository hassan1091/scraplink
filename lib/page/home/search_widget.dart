import 'package:flutter/material.dart';
import 'package:scraplink/constants.dart';
import 'package:scraplink/my_theme.dart';
import 'package:scraplink/page/home/available_part.dart';
import 'package:scraplink/widget/my_dropdown_button.dart';
import 'package:scraplink/widget/my_text_form_field.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<StatefulWidget> createState() => SearchState();
}

class SearchState extends State<SearchWidget> {
  final TextEditingController _yearController = TextEditingController();
  String? _selectedMake;
  String? _selectedModel;
  String? _selectedCategory;

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
            label: "Category:",
            hint: "Select a Category",
            items: Constants.partCategory,
            selectedItem: _selectedCategory,
            onChanged: (s) {
              setState(() {
                _selectedCategory = s;
              });
            },
          ),
          const SizedBox(height: 4),
          MyTextFormField(
              controller: _yearController,
              hint: "Year",
              lable: "Year",
              type: const TextInputType.numberWithOptions()),
          const SizedBox(height: 4),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AvailablePartPage(
                              make: _selectedMake,
                              model: _selectedModel,
                              category: _selectedCategory,
                              year: _yearController.text,
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
