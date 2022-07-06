// ignore_for_file: prefer_const_constructors
import '../models/card.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

Future<CardEntity> createAlbum(CardEntity deneme) async {
  final response = await http.post(Uri.parse('http://10.0.2.2:5002/api/card'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(deneme.toJson()));

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.

    return CardEntity();
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class CardForm extends StatefulWidget {
  const CardForm({Key? key}) : super(key: key);

  @override
  State<CardForm> createState() => _CardFormState();
}

class _CardFormState extends State<CardForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final numberController = TextEditingController();
  final nameController = TextEditingController();
  final dateController = TextEditingController();
  final cvvController = TextEditingController();

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
                controller: numberController,
                decoration: const InputDecoration(
                  hintText: 'Kart Numarası',
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
                obscureText: false,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                  hintText: 'Ad Soyad',
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 70,
                    child: TextFormField(
                      controller: dateController,
                      obscureText: false,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        hintText: 'aa/yy',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    width: 70,
                    child: TextFormField(
                      controller: cvvController,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        hintText: 'cvv',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
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
                    createAlbum(CardEntity(
                        cardNumber: numberController.text,
                        nameSurname: nameController.text,
                        date: dateController.text,
                        secCode: cvvController.text));
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          // Retrieve the text the that user has entered by using the
                          // TextEditingController.
                          content: Text("Card Saved"),
                        );
                      },
                    );
                  }
                },
                child: const Text('Kaydet'),
              ),
            ),
          ],
        ));
  }
}
