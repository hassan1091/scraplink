import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:scraplink/constants.dart';
import 'package:scraplink/my_theme.dart';
import 'package:scraplink/page/home/home.dart';
import 'package:scraplink/page/login.dart';
import 'package:scraplink/page/recycling_company/company_home.dart';
import 'package:scraplink/page/vendor/vendor_home.dart';
import 'package:scraplink/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await dotenv.load();
  await Supabase.initialize(
    url: "https://xpfrdvwfquqhzzijsboi.supabase.co",
    anonKey: dotenv.env['ANON_KEY']!,
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
      home: FutureBuilder(
        future: AppLocalStorage.isExist(AppStorageKey.id),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData && snapshot.data!) {
            return FutureBuilder(
                future: AppLocalStorage.getString(AppStorageKey.role),
                builder: (context, snapshot) {
                  if (snapshot.data == Role.individual.name) {
                    return const HomePage();
                  } else if (snapshot.data == Role.vendor.name) {
                    return const VendorHomePage();
                  } else {
                    return const CompanyHomePage();
                  }
                });
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
