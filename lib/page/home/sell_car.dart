import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scraplink/api/api_service.dart';
import 'package:scraplink/api/model/car.dart';
import 'package:scraplink/constants.dart';
import 'package:scraplink/my_theme.dart';
import 'package:scraplink/widget/my_dropdown_button.dart';
import 'package:scraplink/widget/my_text_form_field.dart';

class SellCarPage extends StatefulWidget {
  const SellCarPage({super.key});

  @override
  State<SellCarPage> createState() => _SellCarPageState();
}

class _SellCarPageState extends State<SellCarPage> {
  final nameController = TextEditingController();
  final yearController = TextEditingController();
  final descriptionController = TextEditingController();
  String? selectedMake;
  String? selectedModel;
  String? selectedLocation;
  String? imagePath;

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
            Row(
              children: [
                Text(
                  "Car image:",
                  style: MyTheme().titleStyle,
                ),
                IconButton(
                    onPressed: _pickImage,
                    icon: Icon(Icons.image, color: MyTheme().primary)),
              ],
            ),
            if (imagePath != null)
              Image.file(
                File(imagePath!),
                height: 200,
              ),
            const SizedBox(height: 4),
            MyTextFormField(
                controller: nameController,
                hint: "Car Name",
                lable: "Car Name"),
            const SizedBox(height: 16),
            MyTextFormField(
                controller: yearController,
                hint: "Year",
                lable: "Year",
                type: const TextInputType.numberWithOptions()),
            const SizedBox(height: 4),
            Text(
              "Description:",
              style: MyTheme().titleStyle,
            ),
            const SizedBox(height: 4),
            Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                child: TextField(
                  controller: descriptionController,
                  maxLines: 3,
                  minLines: 3,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "The car has scratches on the front bumper"),
                )),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                  onPressed: _sell,
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

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imagePath = photo!.path;
    });
  }

  Future<void> _sell() async {
    ApiService()
        .sellCar(
            Car(
                make: selectedMake,
                model: selectedModel,
                year: yearController.text,
                location: selectedLocation,
                name: nameController.text,
                description: descriptionController.text),
            imagePath!)
        .then((_) => Navigator.pop(context))
        .onError((error, stackTrace) => showDialog(
              context: context,
              builder: (context) =>
                  const AlertDialog(title: Text("Failed to sell car")),
            ));
  }
}
