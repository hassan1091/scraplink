import 'package:flutter/material.dart';
import 'package:scraplink/api/api_service.dart';
import 'package:scraplink/page/home/home.dart';
import 'package:scraplink/page/register.dart';
import 'package:scraplink/widget/my_text_form_field.dart';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
            child: ListView(
          shrinkWrap: true,
          children: [
            const Image(
                image: AssetImage("assets/images/logoNoBackground.png")),
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
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(),
                    ));
              },
            ),
            ElevatedButton(onPressed: login, child: const Text("Login"))
          ],
        )),
      ),
    );
  }

  void login() {
    ApiService().login(emailController.text, passwordController.text).then((_) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
    }).onError((error, stackTrace) => showDialog(
        context: context,
        builder: (context) =>
            const AlertDialog(title: Text("Login failed, try again"))));
  }
}
