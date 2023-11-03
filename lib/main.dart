import 'package:flutter/material.dart';
import 'package:scraplink/my_theme.dart';
import 'package:scraplink/page/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ScrapLink',
      theme: ThemeData(
        primaryColor: MyTheme().primary,
        colorScheme: ColorScheme.fromSeed(seedColor: MyTheme().primary),
      ),
      home: const LoginPage(),
    );
  }
}
