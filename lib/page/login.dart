import 'package:flutter/material.dart';
import 'package:scraplink/api/api_service.dart';
import 'package:scraplink/constants.dart';
import 'package:scraplink/page/home/home.dart';
import 'package:scraplink/page/register.dart';
import 'package:scraplink/page/vendor/vendor_home.dart';
import 'package:scraplink/widget/my_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String groupValue = Role.individual.name;

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
            const SizedBox(height: 6),
            MyTextFormField(
              controller: passwordController,
              lable: "Password",
              hint: "Password",
            ),
            const SizedBox(height: 4),
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
            const SizedBox(height: 4),
            InkWell(
              onTap: _register,
              child: const Text(
                "Create new account",
                style: TextStyle(
                    color: Colors.blue, decoration: TextDecoration.underline),
              ),
            ),
            ElevatedButton(onPressed: _login, child: const Text("Login"))
          ],
        )),
      ),
    );
  }

  void _login() {
    ApiService()
        .login(emailController.text, passwordController.text, groupValue)
        .then((_) {
      if (groupValue == Role.vendor.name) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const VendorHomePage()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
    }).onError((error, stackTrace) => showDialog(
            context: context,
            builder: (context) =>
                const AlertDialog(title: Text("Login failed, try again"))));
  }

  void _register() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const RegisterPage()));
  }
}
