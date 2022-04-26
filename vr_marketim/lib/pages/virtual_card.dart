// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../forms/card_form.dart';

class VirtualCard extends StatefulWidget {
  const VirtualCard({Key? key}) : super(key: key);

  @override
  State<VirtualCard> createState() => _VirtualCardState();
}

class _VirtualCardState extends State<VirtualCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login - Register"),
        ),
        body: SingleChildScrollView(
          child: CardForm(),
        ));
  }
}
