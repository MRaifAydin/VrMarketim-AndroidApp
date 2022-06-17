import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:vr_marketim/basketEntity.dart';
import 'package:vr_marketim/products.dart';

Future<List> fetchProducts() async {
  final response = await http
      .get(Uri.parse('http://10.0.2.2:5002/api/baskets/getAllBasket/123321'));

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

Future<http.Response> deleteAlbum(String id) async {
  final http.Response response = await http.delete(
    Uri.parse('http://10.0.2.2:5002/api/baskets/123321/' + id),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  return response;
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
              child: FloatingActionButton.small(
                heroTag: i,
                onPressed: () {
                  setState(() {
                    deleteRow(snapshot[i].id, i);
                    debugPrint("setted state");
                  });
                },
                child: Icon(Icons.delete),
                backgroundColor: Colors.red,
              ),
            ))
          ],
        ),
      );
    }
    return rows;
  }

  String notify() {
    return 'uyarı';
  }

  deleteRow(int id, int i) {
    deleteAlbum(id.toString());
    debugPrint(rows[i].toString());
    debugPrint("before remove");
    rows.clear();
    debugPrint(rows.length.toString());
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
                              child: FloatingActionButton.small(
                        onPressed: null,
                        child: Icon(Icons.delete),
                      ))),
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
