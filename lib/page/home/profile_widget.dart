import 'package:flutter/material.dart';
import 'package:scraplink/my_theme.dart';
import 'package:scraplink/page/home/car_details.dart';
import 'package:scraplink/page/register.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const _ProfileHeader(),
          const SizedBox(
            height: 4,
          ),
          const Divider(
            color: Colors.black,
            height: 4,
          ),
          const SizedBox(
            height: 4,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: 10,
              itemBuilder: (context, index) => _CarCard(
                "Toyota Camry",
                2013,
                "https://www.copart.com/content/us/en/images/landing-pages/FrontEnd.jpg",
                () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const CarDetailsPage()));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CarCard extends StatelessWidget {
  const _CarCard(this.name, this.year, this.image, this.onPressed);

  final String name;
  final int year;
  final String image;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            const Image(
              image: NetworkImage(
                  "https://www.copart.com/content/us/en/images/landing-pages/FrontEnd.jpg"),
              height: 116,
              width: 124,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: MyTheme().titleStyle,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  year.toString(),
                  style: MyTheme().subtitleStyle,
                )
              ],
            ),
          ],
        ),
        FloatingActionButton(
          onPressed: onPressed,
          child: const Icon(Icons.arrow_forward_ios),
        ),
        const SizedBox()
      ]),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.person_outline,
          size: 124,
        ),
        const SizedBox(
          width: 4,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ali hassan",
              style: MyTheme().titleStyle,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              RegisterPage(isEditProfile: true)));
                },
                child: Text(
                  "Edit profile",
                  style: MyTheme().buttonTextStyle,
                ))
          ],
        )
      ],
    );
  }
}
