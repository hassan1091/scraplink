import 'package:flutter/material.dart';
import 'package:scraplink/main.dart';
import 'package:scraplink/page/home/map_widget.dart';
import 'package:scraplink/page/recycling_company/company_home_widget.dart';
import 'package:scraplink/shared_preferences.dart';

class CompanyHomePage extends StatefulWidget {
  const CompanyHomePage({super.key});

  @override
  State<CompanyHomePage> createState() => _CompanyHomePageState();
}

class _CompanyHomePageState extends State<CompanyHomePage> {
  List<Widget> views = [
    const CompanyHomeWidget(),
    const MapWidget(),
  ];

  List<String> titles = [
    "Home",
    "Nearby Yards",
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titles[selectedIndex]), actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            AppLocalStorage.delete(AppStorageKey.id).then((_) =>
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const MyApp())));
          },
        )
      ]),
      body: views[selectedIndex],
      bottomSheet: BottomNavigationBar(
          onTap: (selected) {
            setState(() {
              selectedIndex = selected;
            });
          },
          currentIndex: selectedIndex,
          items: const [
            BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
            BottomNavigationBarItem(
                label: "Nearby Yards", icon: Icon(Icons.map)),
          ]),
    );
  }
}
