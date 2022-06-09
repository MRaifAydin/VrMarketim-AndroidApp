// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'drawer_widget.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const appTitle = 'Main Screen VrMarketim Demo';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: appTitle,
      home: DrawerWidget(title: appTitle),
    );
  }
}
