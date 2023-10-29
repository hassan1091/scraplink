import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    super.key,
    required this.controller, required this.hint, required this.lable,
  });

  final TextEditingController controller;
  final String hint;
  final String lable;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: true,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          label: Text(
            lable,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          hintText: hint),
    );
  }
}
