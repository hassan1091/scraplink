import 'package:flutter/material.dart';
import 'package:scraplink/page/home/home_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> views = [
    const HomeWidget(),
    const Text("Map"),
    const Text("Search"),
    const Text("profile"),
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
      appBar: AppBar(title: Text(titles[selectedIndex])),
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
            BottomNavigationBarItem(label: "home", icon: Icon(Icons.home)),
            BottomNavigationBarItem(label: "map", icon: Icon(Icons.map)),
            BottomNavigationBarItem(label: "search", icon: Icon(Icons.search)),
            BottomNavigationBarItem(label: "person", icon: Icon(Icons.person)),
          ]),
    );
  }
}
