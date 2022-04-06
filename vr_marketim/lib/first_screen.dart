// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First Screen of Multi Page"),
      ),
      body: Text("First Page"),
    );
  }
}
