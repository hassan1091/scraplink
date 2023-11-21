import 'package:flutter/material.dart';
import 'package:scraplink/main.dart';
import 'package:scraplink/page/vendor/vendor_home_widget.dart';
import 'package:scraplink/page/vendor/vendor_map_widget.dart';
import 'package:scraplink/page/vendor/vendor_search_widget.dart';
import 'package:scraplink/shared_preferences.dart';

class VendorHomePage extends StatefulWidget {
  const VendorHomePage({super.key});

  @override
  State<VendorHomePage> createState() => _VendorHomePageState();
}

class _VendorHomePageState extends State<VendorHomePage> {
  List<Widget> views = [
    const VendorHomeWidget(),
    const VendorMapWidget(),
    const VendorSearchPage(),
    // const VendorProfilePage(),
  ];

  List<String> titles = [
    "Home",
    "Nearby Recycling Company",
    "Search",
    // "Profile",
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
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          items: const [
            BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
            BottomNavigationBarItem(
                label: "Nearby Recycling Company", icon: Icon(Icons.map)),
            BottomNavigationBarItem(label: "Search", icon: Icon(Icons.search)),
            BottomNavigationBarItem(label: "Profile", icon: Icon(Icons.person)),
          ]),
      floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
            size: 50,
          ),
          onPressed: () {}),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
