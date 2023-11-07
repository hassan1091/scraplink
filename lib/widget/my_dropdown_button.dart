import 'package:flutter/material.dart';
import 'package:scraplink/my_theme.dart';

class MyDropdownButton extends StatefulWidget {
  const MyDropdownButton({super.key,
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
  State<MyDropdownButton> createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
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
