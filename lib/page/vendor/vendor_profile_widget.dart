import 'package:flutter/material.dart';
import 'package:scraplink/api/api_service.dart';
import 'package:scraplink/api/model/user_profile.dart';
import 'package:scraplink/my_theme.dart';
import 'package:scraplink/page/register.dart';
import 'package:scraplink/page/vendor/vendor_inventory.dart';

class VendorProfileWidget extends StatelessWidget {
  const VendorProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
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
          const SizedBox(height: 16),
          _MyImageButton(
              imageUrl: "https://i.imgur.com/AevlkOd.jpg",
              text: "Parts",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const VendorInventoryPage("Parts")));
              }),
          const SizedBox(height: 16),
          _MyImageButton(
              imageUrl: "https://i.imgur.com/kQYa2tf.jpg",
              text: "Raw Material",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const VendorInventoryPage("Material")));
              }),
          const SizedBox(height: 16),
          _MyImageButton(
              imageUrl: "https://i.imgur.com/hEbImj7.jpg",
              text: "Salvage Cars",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const VendorInventoryPage("Cars")));
              }),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

class _MyImageButton extends StatelessWidget {
  const _MyImageButton(
      {required this.imageUrl, required this.text, required this.onTap});

  final String imageUrl;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      child: SizedBox(
        width: 300,
        height: 200,
        child: InkWell(
          radius: 100,
          onTap: onTap,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Ink.image(
                fit: BoxFit.cover,
                image: NetworkImage(imageUrl),
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  margin: const EdgeInsets.only(right: 50, bottom: 25),
                  decoration: BoxDecoration(
                    color: MyTheme().primary.withOpacity(0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ))
            ],
          ),
        ),
      ),
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
