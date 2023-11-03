import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    super.key,
    required this.controller,
    required this.hint,
    required this.lable,
    this.autofocus = false,
  });

  final TextEditingController controller;
  final String hint;
  final String lable;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: autofocus,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          label: Text(
            lable,
          ),
          hintText: hint),
    );
  }
}
