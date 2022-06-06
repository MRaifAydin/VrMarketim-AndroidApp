// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response =
      await http.get(Uri.parse('http://10.0.2.2:8082/api/products/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final int id;
  final String name;
  final String volume;
  final int pcs;
  final String description;

  const Album({
    required this.id,
    required this.name,
    required this.volume,
    required this.pcs,
    required this.description,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      name: json['name'],
      volume: json['volume'],
      pcs: json['pcs'],
      description: json['description'],
    );
  }
}
