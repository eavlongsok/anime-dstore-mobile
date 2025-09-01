import 'package:anime_dstore_mobile/utils/index.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Item {
  final int id;
  final String name;
  final int category;
  final String image;
  final String price;
  final String description;

  // Constructor
  const Item({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
    required this.price,
    required this.description,
  });

factory Item.fromJson(Map<String, dynamic> json) {
  return Item(
    id: json['id'] ?? 0,
    name: json['name'] ?? 'Unknown',
    category: json['category'] ?? 0,
    image: json['image'] ?? '',
    price: json['price']?.toString() ?? '0',
    description: json['description'] ?? '',
  );
}

}

List<Item> parseItem(String responseBody) {
  final parsed = jsonDecode(responseBody);

  // example response
  // {"success":true,"message":"Search successful.","data":{"items":[{"id":1,"name":"Goku tshirt","category":1,"image":"Who","price":"20","description":"1"}]}}
  return parsed['data']['items']
      .map<Item>((json) => Item.fromJson(json))
      .toList();
}

Future<List<Item>> getItem(
    String query, List<dynamic> selectedCategories) async {
  String categories = selectedCategories.join('&categories[]=');

  print('Selected categories: $selectedCategories');

  if (categories.isEmpty) {
    categories = '';
  } else {
    categories = '&categories[]=${categories}';
  }

  final response = await http
      .get(Uri.parse('$externalApiUrl/api/items?q=$query$categories'));
  
  print('$externalApiUrl/api/items?q=$query$categories');
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    return parseItem(response.body);
  }
  throw Exception('Failed to load items');
}
