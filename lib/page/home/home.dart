import 'package:flutter/material.dart';
import 'package:scraplink/page/home/home_widget.dart';
import 'package:scraplink/page/home/map_widget.dart';
import 'package:scraplink/page/home/profile_widget.dart';
import 'package:scraplink/page/login.dart';
import 'package:scraplink/page/search.dart';
import 'package:scraplink/page/sell_car.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> views = [
    const HomeWidget(),
    const MapWidget(),
    const SearchPage(),
    const ProfilePage(),
  ];

  List<String> titles = [
    "Home",
    "Nearby yards",
    "Search",
    "Profile",
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titles[selectedIndex]), actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ));
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
                label: "Nearby yards", icon: Icon(Icons.map)),
            BottomNavigationBarItem(label: "Search", icon: Icon(Icons.search)),
            BottomNavigationBarItem(label: "Profile", icon: Icon(Icons.person)),
          ]),
      floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
            size: 50,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SellCarPage(),
                ));
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
