// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:vr_marketim/pages/virtual_card.dart';

import './pages/register_login.dart';
import './pages/update_user.dart';
import './pages/basket.dart';
import './pages/virtual_card.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: ElevatedButton(onPressed: null, child: Text("Open Vr App")),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Text('İşlemler'),
            ),
            ListTile(
              title: const Text('Login - Register'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterLogin()),
                );
              },
            ),
            ListTile(
              title: const Text('Edit Account Info'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UpdateUser()),
                );
              },
            ),
            ListTile(
              title: const Text('Basket'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BasketTable()),
                );
              },
            ),
            ListTile(
              title: const Text('Virtual Card'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VirtualCard()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
