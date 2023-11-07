import 'package:flutter/material.dart';
import 'package:scraplink/my_theme.dart';
import 'package:scraplink/widget/my_dropdown_button.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => SearchState();
}

class SearchState extends State<SearchPage> {
  String? selectedType;
  String? selectedManufacturer;
  String? selectedCar;
  String? selectedModel;
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          MyDropdownButton(
            label: "Type:",
            hint: "Select a Type",
            items: const ["Type1", "Type2", "Type3"],
            selectedItem: selectedType,
            onChanged: (s) {
              setState(() {
                selectedType = s;
              });
            },
          ),
          const SizedBox(height: 16),
          MyDropdownButton(
            label: "Manufacturer:",
            hint: "Select a Manufacturer",
            items: const ["Manufacturer1", "Manufacturer2", "Manufacturer3"],
            selectedItem: selectedManufacturer,
            onChanged: (s) {
              setState(() {
                selectedManufacturer = s;
              });
            },
          ),
          const SizedBox(height: 16),
          MyDropdownButton(
            label: "Car:",
            hint: "Select a Car",
            items: const ["Car1", "Car2", "Car3"],
            selectedItem: selectedCar,
            onChanged: (s) {
              setState(() {
                selectedCar = s;
              });
            },
          ),
          const SizedBox(height: 16),
          MyDropdownButton(
            label: "Model:",
            hint: "Select a Model",
            items: const ["Model1", "Model2", "Model3"],
            selectedItem: selectedModel,
            onChanged: (s) {
              setState(() {
                selectedModel = s;
              });
            },
          ),
          const SizedBox(height: 16),
          MyDropdownButton(
            label: "Category:",
            hint: "Select a Category",
            items: const ["Category1", "Category2", "Category3"],
            selectedItem: selectedCategory,
            onChanged: (s) {
              setState(() {
                selectedCategory = s;
              });
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
              onPressed: () {},
              child: Text(
                "Search",
                style: MyTheme().buttonTextStyle,
              ))
        ],
      ),
    );
  }
}
