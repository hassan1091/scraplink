import 'package:flutter/material.dart';
import 'package:scraplink/my_theme.dart';
import 'package:scraplink/page/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: "https://xpfrdvwfquqhzzijsboi.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhwZnJkdndmcXVxaHp6aWpzYm9pIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTkxMTE0ODUsImV4cCI6MjAxNDY4NzQ4NX0.jmXg5tfmI1k_RErtRQyci_upcHLIh5RCs3ShhtksfZs",
  );
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
