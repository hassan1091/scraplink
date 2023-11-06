import 'package:flutter/material.dart';
import 'package:scraplink/my_theme.dart';

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
          _SearchDropdown(
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
          _SearchDropdown(
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
          _SearchDropdown(
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
          _SearchDropdown(
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
          _SearchDropdown(
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

class _SearchDropdown extends StatefulWidget {
  const _SearchDropdown({
    required this.label,
    required this.hint,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  });

  final String label;
  final String hint;
  final List<String> items;
  final String? selectedItem;
  final Function(String?) onChanged;

  @override
  State<_SearchDropdown> createState() => _SearchDropdownState();
}

class _SearchDropdownState extends State<_SearchDropdown> {
  String? selectedItem;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Text(
            widget.label,
            style: MyTheme().titleStyle,
          ),
        ),
        Expanded(
          child: DropdownButton(
            isExpanded: true,
            value: selectedItem,
            hint: Text(
              widget.hint,
              style: MyTheme().subtitleStyle,
            ),
            items: widget.items.map((String item) {
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
                selectedItem = s;
              });
              widget.onChanged(s);
            },
            icon: const Icon(Icons.arrow_drop_down),
          ),
        )
      ],
    );
  }
}
