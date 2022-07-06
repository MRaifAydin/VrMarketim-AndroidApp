import 'package:flutter/material.dart';
import 'package:vr_marketim/models/updateUser.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<UpdateUser> createAlbum(UpdateUser deneme) async {
  final response =
      await http.put(Uri.parse('http://10.0.2.2:5002/api/accounts'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
          },
          body: jsonEncode(deneme.toJson()));

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    debugPrint("updateUser");
    return UpdateUser();
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class UpdateForm extends StatefulWidget {
  const UpdateForm({Key? key}) : super(key: key);

  @override
  State<UpdateForm> createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final mailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
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
              child: TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Name',
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
                controller: surnameController,
                decoration: const InputDecoration(
                  hintText: 'Surname',
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
                controller: addressController,
                decoration: const InputDecoration(
                  hintText: 'Address',
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
                    // Process data.

                    createAlbum(UpdateUser(
                        id: 15,
                        mail: mailController.text,
                        password: passwordController.text,
                        name: nameController.text,
                        surname: surnameController.text,
                        address: addressController.text));
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          // Retrieve the text the that user has entered by using the
                          // TextEditingController.
                          content: Text("Info Updated"),
                        );
                      },
                    );
                  }
                },
                child: const Text('Register'),
              ),
            ),
          ],
        ));
  }
}
