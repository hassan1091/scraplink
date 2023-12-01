import 'package:flutter/material.dart';
import 'package:scraplink/api/api_service.dart';
import 'package:scraplink/api/model/user_profile.dart';
import 'package:scraplink/constants.dart';
import 'package:scraplink/field_validation.dart';
import 'package:scraplink/main.dart';
import 'package:scraplink/widget/my_dropdown_button.dart';
import 'package:scraplink/widget/my_text_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, this.profile});

  final UserProfile? profile;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _phoneController;
  final _formKey = GlobalKey<FormState>();

  String _groupValue = Role.individual.name;
  String? _selectedLocation;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.profile?.name);
    _emailController = TextEditingController(text: widget.profile?.email);
    _passwordController = TextEditingController(text: widget.profile?.password);
    _phoneController = TextEditingController(text: widget.profile?.phoneNumber);
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
          key: _formKey,
          child: ListView(children: [
            const SizedBox(height: 6),
            MyTextFormField(
              controller: _nameController,
              hint: "Name",
              lable: "Name",
              autofocus: widget.profile == null,
              validator: FieldValidation.validateName,
            ),
            const SizedBox(height: 12),
            MyTextFormField(
              controller: _emailController,
              hint: "Email",
              lable: "Email",
              validator: FieldValidation.validateEmail,
            ),
            const SizedBox(height: 12),
            MyTextFormField(
              controller: _passwordController,
              hint: "Password",
              lable: "Password",
              validator: FieldValidation.validatePassword,
            ),
            const SizedBox(height: 12),
            MyTextFormField(
              controller: _phoneController,
              hint: "05########",
              lable: "Phone",
              validator: FieldValidation.validatePhone,
            ),
            const SizedBox(height: 12),
            MyDropdownButton(
              label: "Location:",
              hint: "Select a Location",
              items: Constants.regions,
              selectedItem: _selectedLocation,
              onChanged: (s) {
                setState(() {
                  _selectedLocation = s;
                });
              },
            ),
            const SizedBox(height: 12),
            if (widget.profile == null)
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
            const SizedBox(height: 12),
            ElevatedButton(
                onPressed: _onPressed,
                child: Text(widget.profile != null ? "Save" : "Create Account"))
          ]),
        ),
      ),
    );
  }

  void _onPressed() {
    if (_formKey.currentState!.validate()) {
      final userProfile = UserProfile(
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          phoneNumber: _phoneController.text,
          location: _selectedLocation);
      if (widget.profile == null) {
        ApiService().register(userProfile, _groupValue).then((_) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MyApp()),
              (route) => false);
        }).onError((error, stackTrace) => showDialog(
            context: context,
            builder: (context) =>
                const AlertDialog(title: Text("Register failed, try again"))));
      } else {
        ApiService()
            .updateProfile(userProfile)
            .then((_) => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MyApp()),
                (route) => false))
            .onError((error, stackTrace) => showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                    title: Text("Edit profile failed, try again"))));
      }
    }
  }
}
