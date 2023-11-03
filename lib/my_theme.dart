import 'package:flutter/material.dart';

class MyTheme {
  final double _titleFontSize = 20;
  final double _subtitleFontSize = 16;
  final Color primary = const Color(0xff810000);
  late final TextStyle? titleStyle = TextStyle(
      color: primary, fontSize: _titleFontSize, fontWeight: FontWeight.bold);
  late final TextStyle? subtitleStyle =
      TextStyle(color: primary, fontSize: _subtitleFontSize);
  late final TextStyle? buttonTextStyle = TextStyle(fontSize: _titleFontSize);
}
