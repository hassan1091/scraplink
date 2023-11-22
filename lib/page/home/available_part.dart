import 'package:flutter/material.dart';
import 'package:scraplink/widget/scraps.dart';

class AvailablePartPage extends StatelessWidget {
  const AvailablePartPage(
      {super.key, this.make, this.model, this.category, this.year});

  final String? make;
  final String? model;
  final String? category;
  final String? year;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Available Part ${make ?? ""}")),
      body: ScrapsWidget(
          make: make, model: model, category: category, year: year),
    );
  }
}
