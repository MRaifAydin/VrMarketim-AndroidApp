// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:vr_marketim/models/products.dart';

Future<List> fetchProducts() async {
  final response = await http
      .get(Uri.parse('http://10.0.2.2:5002/api/baskets/getAllBasket/15'));

  if (response.statusCode == 200) {
    List products = (json.decode(response.body) as List)
        .map((data) => Products.fromJson(data))
        .toList();
    return products;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class BasketTable extends StatefulWidget {
  const BasketTable({Key? key}) : super(key: key);

  @override
  State<BasketTable> createState() => _BasketTableState();
}

class _BasketTableState extends State<BasketTable> {
  late Future<List> basketAlbum;
  List<DataRow> rows = [];

  List<DataRow> createRows(snapshot) {
    int sum = 0;
    for (int i = 0; i < snapshot.length; i++) {
      rows.add(
        DataRow(
          cells: <DataCell>[
            DataCell(Center(
              child: Text(snapshot[i].name.toString()),
            )),
            DataCell(Center(
              child: Text(snapshot[i].description.toString()),
            )),
            DataCell(Center(
              child: Text(snapshot[i].pcs.toString() + "TL"),
            )),
          ],
        ),
      );
      sum = sum + int.parse(snapshot[i].pcs.toString());
    }
    rows.add(
      DataRow(
        cells: <DataCell>[
          DataCell(Center(
            child: Text(
              "Toplam",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          )),
          DataCell(Center(
            child: Text(
              "Fiyat",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          )),
          DataCell(Center(
            child: Text(
              sum.toString() + "TL",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          )),
        ],
      ),
    );
    return rows;
  }

  String notify() {
    return 'uyarı';
  }

  @override
  void initState() {
    super.initState();
    basketAlbum = fetchProducts();
    setState(() {
      notify();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Basket")),
        body: ConstrainedBox(
          constraints:
              BoxConstraints.expand(width: MediaQuery.of(context).size.width),
          child: SingleChildScrollView(
            child: FutureBuilder<List>(
              future: basketAlbum,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                          label: Expanded(
                        child: Text(
                          'Name',
                          style: TextStyle(fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                        ),
                      )),
                      DataColumn(
                          label: Expanded(
                        child: Text(
                          'Description',
                          style: TextStyle(fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                        ),
                      )),
                      DataColumn(
                          label: Expanded(
                        child: Text(
                          'Price',
                          style: TextStyle(fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                        ),
                      )),
                    ],
                    rows: createRows(snapshot.data!),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ),
        ));
  }
}
