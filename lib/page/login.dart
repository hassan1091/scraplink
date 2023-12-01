import 'package:flutter/material.dart';
import 'package:scraplink/api/api_service.dart';
import 'package:scraplink/constants.dart';
import 'package:scraplink/field_validation.dart';
import 'package:scraplink/main.dart';
import 'package:scraplink/page/register.dart';
import 'package:scraplink/widget/my_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _groupValue = Role.individual.name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                const Image(
                    image: AssetImage("assets/images/logoNoBackground.png")),
                MyTextFormField(
                  controller: _emailController,
                  lable: "Email",
                  hint: "Email",
                  autofocus: true,
                  validator: FieldValidation.validateEmail,
                ),
                const SizedBox(height: 6),
                MyTextFormField(
                  controller: _passwordController,
                  lable: "Password",
                  hint: "Password",
                  isPassword: true,
                  validator: FieldValidation.validateRequired,
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Individual'),
                    Radio<String>(
                      value: Role.individual.name,
                      groupValue: _groupValue,
                      onChanged: (value) {
                        setState(() {
                          _groupValue = value!;
                        });
                      },
                    ),
                    const Text('Vendor'),
                    Radio<String>(
                      value: Role.vendor.name,
                      groupValue: _groupValue,
                      onChanged: (value) {
                        setState(() {
                          _groupValue = value!;
                        });
                      },
                    ),
                    const Text('Recycling Company'),
                    Radio<String>(
                      value: Role.recycling_company.name,
                      groupValue: _groupValue,
                      onChanged: (value) {
                        setState(() {
                          _groupValue = value!;
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
                        color: Colors.blue,
                        decoration: TextDecoration.underline),
                  ),
                ),
                ElevatedButton(onPressed: _login, child: const Text("Login"))
              ],
            )),
      ),
    );
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      ApiService()
          .login(_emailController.text, _passwordController.text, _groupValue)
          .then((_) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const MyApp()));
      }).onError((error, stackTrace) => showDialog(
              context: context,
              builder: (context) =>
                  const AlertDialog(title: Text("Login failed, try again"))));
    }
  }

  void _register() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const RegisterPage()));
  }
}
