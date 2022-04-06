// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen of Multi Page"),
      ),
      body: Text("Second Page"),
    );
  }
}
