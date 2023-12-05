import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scraplink/api/api_service.dart';
import 'package:scraplink/api/model/car.dart';
import 'package:scraplink/constants.dart';
import 'package:scraplink/field_validation.dart';
import 'package:scraplink/my_theme.dart';
import 'package:scraplink/widget/my_dropdown_button.dart';
import 'package:scraplink/widget/my_text_form_field.dart';

class SellCarPage extends StatefulWidget {
  const SellCarPage({super.key});

  @override
  State<SellCarPage> createState() => _SellCarPageState();
}

class _SellCarPageState extends State<SellCarPage> {
  final _nameController = TextEditingController();
  final _yearController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedMake;
  String? _selectedModel;
  String? _selectedLocation;
  String? _imagePath;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sell")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
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
              if (_imagePath != null)
                Image.file(
                  File(_imagePath!),
                  height: 200,
                ),
              const SizedBox(height: 4),
              MyTextFormField(
                controller: _nameController,
                hint: "Car Name",
                lable: "Car Name",
                validator: FieldValidation.validateRequired,
              ),
              const SizedBox(height: 16),
              MyTextFormField(
                controller: _yearController,
                hint: "Year",
                lable: "Year",
                type: const TextInputType.numberWithOptions(),
                validator: FieldValidation.validateYear,
              ),
              const SizedBox(height: 4),
              Text(
                "Description:",
                style: MyTheme().titleStyle,
              ),
              const SizedBox(height: 4),
              Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                  child: TextFormField(
                    controller: _descriptionController,
                    maxLines: 3,
                    minLines: 3,
                    validator: FieldValidation.validateRequired,
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
      ),
    );
  }

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imagePath = photo!.path;
    });
  }

  Future<void> _sell() async {
    if (_imagePath == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("image is required")));
    } else if (_formKey.currentState!.validate()) {
      ApiService()
          .sellCar(
              Car(
                  make: _selectedMake,
                  model: _selectedModel,
                  year: _yearController.text,
                  location: _selectedLocation,
                  name: _nameController.text,
                  description: _descriptionController.text),
              _imagePath!)
          .then((_) => Navigator.pop(context))
          .onError((error, stackTrace) => showDialog(
                context: context,
                builder: (context) =>
                    const AlertDialog(title: Text("Failed to sell car")),
              ));
    }
  }
}
