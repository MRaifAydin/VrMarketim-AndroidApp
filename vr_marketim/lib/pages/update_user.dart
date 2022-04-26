// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import '../forms/user_update_form.dart';

class UpdateUser extends StatefulWidget {
  const UpdateUser({Key? key}) : super(key: key);

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Update Personal Info")),
        body: SingleChildScrollView(child: UpdateForm()));
  }
}
