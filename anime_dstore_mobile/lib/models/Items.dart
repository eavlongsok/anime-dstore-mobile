import 'package:anime_dstore_mobile/utils/index.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Items {
  final int id;
  final String name;
  final int category;
  final String image;
  final String price;
  final String description;

  // Constructor
  const Items({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
    required this.price,
    required this.description,
  });

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      image: json['image'],
      price: json['price'],
      description: json['description'],
    );
  }
}

List<Items> parseItems(String responseBody) {
  final parsed = jsonDecode(responseBody);

  // example response
  // {"success":true,"message":"Search successful.","data":{"items":[{"id":1,"name":"Goku tshirt","category":1,"image":"Who","price":"20","description":"1"}]}}
  return parsed['data']['items']
      .map<Items>((json) => Items.fromJson(json))
      .toList();
}

Future<List<Items>> getItems(String query) async {
  final response =
      await http.get(Uri.parse('$externalApiUrl/api/items?q=$query'));
  if (response.statusCode == 200) {
    return parseItems(response.body);
  }
  throw Exception('Failed to load items');
}
