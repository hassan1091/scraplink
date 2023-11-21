import 'package:flutter/material.dart';
import 'package:scraplink/api/api_service.dart';
import 'package:scraplink/api/model/user_profile.dart';
import 'package:scraplink/constants.dart';
import 'package:scraplink/page/home/home.dart';
import 'package:scraplink/page/vendor/vendor_home.dart';
import 'package:scraplink/widget/my_text_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, this.profile});

  final UserProfile? profile;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController phoneController;
  late final TextEditingController cityController;

  String groupValue = Role.individual.name;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.profile?.name);
    emailController = TextEditingController(text: widget.profile?.email);
    passwordController = TextEditingController(text: widget.profile?.password);
    phoneController = TextEditingController(text: widget.profile?.phoneNumber);
    cityController = TextEditingController(text: widget.profile?.city);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.profile != null ? "EditProfile" : "Register"),
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
              autofocus: widget.profile == null,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Individual'),
                Radio<String>(
                  value: Role.individual.name,
                  groupValue: groupValue,
                  onChanged: (value) {
                    setState(() {
                      groupValue = value!;
                    });
                  },
                ),
                const Text('Vendor'),
                Radio<String>(
                  value: Role.vendor.name,
                  groupValue: groupValue,
                  onChanged: (value) {
                    setState(() {
                      groupValue = value!;
                    });
                  },
                ),
                const Text('Recycling Company'),
                Radio<String>(
                  value: Role.recycling_company.name,
                  groupValue: groupValue,
                  onChanged: (value) {
                    setState(() {
                      groupValue = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton(
                onPressed: () => _onPressed(context),
                child: Text(widget.profile != null ? "Save" : "Create Account"))
          ]),
        ),
      ),
    );
  }

  void _onPressed(context) {
    final individual = UserProfile(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        phoneNumber: phoneController.text,
        city: cityController.text);
    if (widget.profile == null) {
      ApiService().register(individual, groupValue).then((_) {
        if (groupValue == Role.vendor.name) {
          return Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const VendorHomePage()),
              (route) => false);
        }
        return Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false);
      }).onError((error, stackTrace) => showDialog(
          context: context,
          builder: (context) =>
              const AlertDialog(title: Text("Register failed, try again"))));
    } else {
      ApiService()
          .updateProfile(individual)
          .then((_) => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (route) => false))
          .onError((error, stackTrace) => showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                  title: Text("Edit profile failed, try again"))));
    }
  }
}
