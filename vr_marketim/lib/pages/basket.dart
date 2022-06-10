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

List<DataRow> createRows(List snapshot) {
  List<DataRow> rows = [];
  for (int i = 0; i < snapshot.length; ++i) {
    rows.add(
      DataRow(
        cells: <DataCell>[
          DataCell(Center(
            child: Text('${snapshot[i].name}'),
          )),
          DataCell(Center(
            child: Text('${snapshot[i].description}'),
          )),
          DataCell(Center(
            child: FloatingActionButton.small(
              heroTag: i,
              onPressed: null,
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
        body: ConstrainedBox(
          constraints:
              BoxConstraints.expand(width: MediaQuery.of(context).size.width),
          child: SingleChildScrollView(
            child: FutureBuilder<List>(
              future: futureAlbum,
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
                    // rows: <DataRow>[
                    //   DataRow(
                    //     cells: <DataCell>[
                    //       DataCell(Center(
                    //         child: Text('${snapshot.data!.length}'),
                    //       )),
                    //     ],
                    //   ),
                    //   DataRow(
                    //     cells: <DataCell>[
                    //       DataCell(Center(
                    //         child: Text('${snapshot.data![1].name}'),
                    //       )),
                    //     ],
                    //   ),
                    // ],
                    rows: createRows(snapshot.data!),
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
        ));
  }
}
