import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vr_marketim/products.dart';

Future<List> fetchAlbum() async {
  final response =
      await http.get(Uri.parse('http://10.0.2.2:5002/api/products'));

  if (response.statusCode == 200) {
    List users = (json.decode(response.body) as List)
        .map((data) => Products.fromJson(data))
        .toList();
    return users;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Widget returnRow(List deneme) {
  return Container();
}

class BasketTable extends StatefulWidget {
  const BasketTable({Key? key}) : super(key: key);

  @override
  State<BasketTable> createState() => _BasketTableState();
}

class _BasketTableState extends State<BasketTable> {
  late Future<List> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Basket")),
      body: SingleChildScrollView(
        child: FutureBuilder<List>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return DataTable(
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
                rows: <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Center(
                        child: Text('${snapshot.data!.length}'),
                      )),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Center(
                        child: Text('${snapshot.data![1].name}'),
                      )),
                    ],
                  ),
                ],
              );
              // return Text(snapshot.data!.name);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
