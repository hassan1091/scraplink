import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scraplink/my_theme.dart';
import 'package:scraplink/widget/my_dropdown_button.dart';
import 'package:scraplink/widget/my_text_form_field.dart';

class SellCarPage extends StatefulWidget {
  const SellCarPage({super.key});

  @override
  State<SellCarPage> createState() => _SellCarPageState();
}

class _SellCarPageState extends State<SellCarPage> {
  final carNameController = TextEditingController();
  String? selectedMake;
  String? selectedModel;
  String? selectedYear;
  String? selectedName;
  String? photoPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sell")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            MyDropdownButton(
              label: "Make:",
              hint: "Select a Make",
              items: const [
                "toyota",
                "jeep",
                "honda",
                "ford",
                "hyundai",
                "kia"
              ],
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
              items: const ["camry", "Model2", "Model3"],
              selectedItem: selectedModel,
              onChanged: (s) {
                setState(() {
                  selectedModel = s;
                });
              },
            ),
            const SizedBox(height: 16),
            MyDropdownButton(
              label: "Year:",
              hint: "Select a Year",
              items: const ["2001", "2002", "2003"],
              selectedItem: selectedYear,
              onChanged: (s) {
                setState(() {
                  selectedYear = s;
                });
              },
            ),
            const SizedBox(height: 16),
            MyTextFormField(
                controller: carNameController,
                hint: "Car Name",
                lable: "Car Name"),
            Row(
              children: [
                Text(
                  "Car image:",
                  style: MyTheme().titleStyle,
                ),
                IconButton(
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? photo =
                          await picker.pickImage(source: ImageSource.gallery);
                      setState(() {
                        photoPath = photo!.path;
                      });
                    },
                    icon: Icon(Icons.image, color: MyTheme().primary)),
              ],
            ),
            if (photoPath != null)
              Image.file(
                File(photoPath!),
                height: 200,
              ),
            Text(
              "Description:",
              style: MyTheme().titleStyle,
            ),
            const SizedBox(height: 4),
            const Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                child: TextField(
                  maxLines: 3,
                  minLines: 3,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "The car has scratches on the front bumper"),
                )),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Sell",
                    style: MyTheme().buttonTextStyle,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
