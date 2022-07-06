import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:vr_marketim/models/login.dart';

bool? loggedIn = false;

Future<Login> createAlbum(Login deneme) async {
  final response =
      await http.post(Uri.parse('http://10.0.2.2:5002/api/accounts/checkUser'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
          },
          body: jsonEncode(deneme.toJson()));

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.

    return Login.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final mailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    mailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5),
              child: TextFormField(
                controller: mailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState!.validate()) {
                    debugPrint(mailController.text);
                    debugPrint(passwordController.text);
                    // Process data.
                    createAlbum(Login(
                        mail: mailController.text,
                        password: passwordController.text));
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          // Retrieve the text the that user has entered by using the
                          // TextEditingController.
                          content: Text("Logged In"),
                        );
                      },
                    );
                  }
                },
                child: const Text('Login'),
              ),
            ),
          ],
        ));
  }
}
