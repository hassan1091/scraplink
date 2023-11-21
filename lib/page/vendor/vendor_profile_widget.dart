import 'package:flutter/material.dart';
import 'package:scraplink/api/api_service.dart';
import 'package:scraplink/api/model/user_profile.dart';
import 'package:scraplink/my_theme.dart';
import 'package:scraplink/page/register.dart';

class VendorProfileWidget extends StatelessWidget {
  const VendorProfileWidget({super.key});

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
        ],
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
