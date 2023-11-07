import 'package:flutter/material.dart';
import 'package:scraplink/page/home/home.dart';
import 'package:scraplink/widget/my_text_form_field.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key, this.isEditProfile = false});

  final bool isEditProfile;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditProfile ? "EditProfile" : "Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(children: [
            const SizedBox(height: 6),
            MyTextFormField(
              controller: nameController,
              hint: "Name",
              lable: "Name",
              autofocus: true,
            ),
            const SizedBox(height: 12),
            MyTextFormField(
                controller: emailController, hint: "Email", lable: "Email"),
            const SizedBox(height: 12),
            MyTextFormField(
                controller: passwordController,
                hint: "Password",
                lable: "Password"),
            const SizedBox(height: 12),
            MyTextFormField(
                controller: phoneController, hint: "Phone", lable: "Phone"),
            const SizedBox(height: 12),
            MyTextFormField(
                controller: cityController, hint: "City", lable: "City"),
            const SizedBox(height: 12),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ));
                },
                child: Text(isEditProfile ? "Save" : "Create Account"))
          ]),
        ),
      ),
    );
  }
}
