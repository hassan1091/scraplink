import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _ProfileHeader(),
        SizedBox(
          height: 4,
        ),
        Divider(
          color: Colors.black,
          height: 4,
        ),
        SizedBox(
          height: 4,
        ),
      ],
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
              "rayan hassan",
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Edit profile",
                  style: TextStyle(fontSize: 20),
                ))
          ],
        )
      ],
    );
  }
}
