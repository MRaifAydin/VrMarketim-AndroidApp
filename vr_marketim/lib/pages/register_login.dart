// ignore_for_file: prefer_const_constructors
// import 'dart:developer';

import 'package:flutter/material.dart';
import '../forms/register_form.dart';
import '../forms/login_form.dart';

bool visible = true;

isPressed() {
  visible = !visible;
}

class RegisterLogin extends StatefulWidget {
  const RegisterLogin({Key? key}) : super(key: key);

  @override
  State<RegisterLogin> createState() => _RegisterLoginState();
}

class _RegisterLoginState extends State<RegisterLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login - Register"),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isPressed();
                    });
                  },
                  child: const Text("Register - Login")),
            ],
          ),
          Visibility(visible: !visible, child: RegisterForm()),
          Visibility(visible: visible, child: LoginForm()),
        ]),
      ),
    );
  }
}
