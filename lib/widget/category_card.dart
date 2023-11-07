import 'package:flutter/material.dart';
import 'package:scraplink/page/home/available_part.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black)],
            borderRadius: BorderRadius.all(Radius.circular(8)),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFE97171), Color(0xFFFFCB8E)])),
        child: Column(
          children: [
            SizedBox(
              height: 100,
              width: 150,
              child: Image(
                  image: AssetImage("assets/images/${name}_logo.png"),
                  fit: BoxFit.contain),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AvailablePartPage(),
            ));
      },
    );
  }
}
