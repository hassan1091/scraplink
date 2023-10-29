import 'package:flutter/material.dart';
import '../widget/my_text_form_field.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<LoginPage> {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
            child: ListView(
          shrinkWrap: true,
          children: [
            MyTextFormField(controller: emailController,lable: "Email",hint: "Email",)
          ],
        )),
      )),
    );
  }
}