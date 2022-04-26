// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class BasketTable extends StatefulWidget {
  const BasketTable({Key? key}) : super(key: key);

  @override
  State<BasketTable> createState() => _BasketTableState();
}

class _BasketTableState extends State<BasketTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Basket")),
      body: SingleChildScrollView(
        child: DataTable(
          columns: const <DataColumn>[
            DataColumn(
                label: Expanded(
              child: Text(
                'Products',
                style: TextStyle(fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            )),
          ],
          rows: const <DataRow>[
            DataRow(
              cells: <DataCell>[
                DataCell(Center(
                  child: Text('Wine'),
                )),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Center(child: Text('Barbecue'))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
