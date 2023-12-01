import 'package:flutter/material.dart';
import 'package:scraplink/api/api_service.dart';
import 'package:scraplink/api/model/raw_material.dart';
import 'package:scraplink/constants.dart';
import 'package:scraplink/field_validation.dart';
import 'package:scraplink/my_theme.dart';
import 'package:scraplink/widget/my_dropdown_button.dart';
import 'package:scraplink/widget/my_text_form_field.dart';

class SellMaterialPage extends StatefulWidget {
  const SellMaterialPage({super.key});

  @override
  State<SellMaterialPage> createState() => _SellMaterialPageState();
}

class _SellMaterialPageState extends State<SellMaterialPage> {
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedType;
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
                label: "Type:",
                hint: "Select a Type",
                items: Constants.materialTypes,
                selectedItem: _selectedType,
                onChanged: (s) {
                  setState(() {
                    _selectedType = s;
                  });
                },
              ),
              const SizedBox(height: 16),
              MyTextFormField(
                controller: _priceController,
                hint: "Price",
                lable: "Price",
                type: TextInputType.number,
                validator: FieldValidation.validateRequired,
              ),
              const SizedBox(height: 16),
              Text(
                "Description:",
                style: MyTheme().titleStyle,
              ),
              const SizedBox(height: 4),
              Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 0,
                  ),
                  child: TextFormField(
                    controller: _descriptionController,
                    maxLines: 3,
                    minLines: 3,
                    validator: FieldValidation.validateRequired,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "The scrap part one year used"),
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

  Future<void> _sell() async {
    if (_formKey.currentState!.validate()) {
      ApiService()
          .sellRawMaterial(RawMaterial(
              type: _selectedType, description: _descriptionController.text))
          .then((_) => Navigator.pop(context))
          .onError((error, stackTrace) {
        debugPrint(error.toString());

        return showDialog(
          context: context,
          builder: (context) =>
              const AlertDialog(title: Text("The selling Failed")),
        );
      });
    }
  }
}
