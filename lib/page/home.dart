import 'package:flutter/material.dart';
import 'package:scraplink/widget/category_card.dart';

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

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: views[selectedIndex],
      floatingActionButton:
          FloatingActionButton(child: const Icon(Icons.add), onPressed: () {}),
      bottomSheet: BottomNavigationBar(
          onTap: (selected) {
            setState(() {
              selectedIndex = selected;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(label: "home", icon: Icon(Icons.home)),
            BottomNavigationBarItem(label: "map", icon: Icon(Icons.map)),
            BottomNavigationBarItem(label: "search", icon: Icon(Icons.search)),
            BottomNavigationBarItem(label: "person", icon: Icon(Icons.person)),
          ]),
    );
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(children: const [
      SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CategoryCard(name: "toyota"),
          CategoryCard(name: "jeep"),
        ],
      ),
      SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CategoryCard(name: "honda"),
          CategoryCard(name: "ford"),
        ],
      ),
      SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CategoryCard(name: "hyundai"),
          CategoryCard(name: "kia"),
        ],
      ),
      SizedBox(height: 4),
      Divider(
        color: Colors.black,
      ),
    ]);
  }
}
