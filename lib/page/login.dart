import 'package:flutter/material.dart';

import '../widget/my_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
            const Image(image: AssetImage("assets/images/logoNoBackground.png")),
            MyTextFormField(
              controller: emailController,
              lable: "Email",
              hint: "Email",
              autofocus: true,
            ),
            const SizedBox(
              height: 6,
            ),
            MyTextFormField(
              controller: passwordController,
              lable: "Password",
              hint: "Password",
            ),
            const SizedBox(
              height: 4,
            ),
            InkWell(
              child: const Text(
                "Create new account",
                style: TextStyle(
                    color: Colors.blue, decoration: TextDecoration.underline),
              ),
              onTap: () {},
            ),
            ElevatedButton(onPressed: (){}, child: const Text("Login"))
          ],
        )),
      )),
    );
  }
}
