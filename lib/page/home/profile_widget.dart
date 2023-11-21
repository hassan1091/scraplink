import 'package:flutter/material.dart';
import 'package:scraplink/api/api_service.dart';
import 'package:scraplink/api/model/car.dart';
import 'package:scraplink/api/model/user_profile.dart';
import 'package:scraplink/my_theme.dart';
import 'package:scraplink/page/home/car_details.dart';
import 'package:scraplink/page/register.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          FutureBuilder(
            future: ApiService().getProfile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const _ProfileHeader();
              }
              return _ProfileHeader(snapshot.data);
            },
          ),
          const SizedBox(height: 4),
          const Divider(
            color: Colors.black,
            height: 4,
          ),
          const SizedBox(height: 4),
          FutureBuilder(
            future: ApiService().getCars(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              List<Car> cars = snapshot.data!;
              return Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: cars.length,
                      itemBuilder: (context, index) => _CarCard(
                          "${cars[index].make} ${cars[index].model}",
                          int.parse(cars[index].year!),
                          cars[index].imageUrl!,
                          () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      CarDetailsPage(cars[index]))))));
            },
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
            Image(
              image: NetworkImage(image),
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
  const _ProfileHeader([this.profile]);

  final UserProfile? profile;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.person_outline,
          size: 124,
        ),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              profile?.name ?? "#####",
              style: MyTheme().titleStyle,
            ),
            ElevatedButton(
                onPressed: () {
                  if (profile != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RegisterPage(profile: profile!)));
                  }
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
