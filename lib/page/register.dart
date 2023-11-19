import 'package:flutter/material.dart';
import 'package:scraplink/api/api_service.dart';
import 'package:scraplink/api/model/individual.dart';
import 'package:scraplink/page/home/home.dart';
import 'package:scraplink/widget/my_text_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, this.profile});

  final Individual? profile;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController phoneController;
  late final TextEditingController cityController;

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
            ElevatedButton(
                onPressed: () => _register(context),
                child: Text(widget.profile != null ? "Save" : "Create Account"))
          ]),
        ),
      ),
    );
  }

  void _register(context) {
    final individual = Individual(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        phoneNumber: phoneController.text,
        city: cityController.text);
    ApiService()
        .register(individual)
        .then((_) => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false))
        .onError((error, stackTrace) => showDialog(
            context: context,
            builder: (context) =>
                const AlertDialog(title: Text("Register failed, try again"))));
  }
}
