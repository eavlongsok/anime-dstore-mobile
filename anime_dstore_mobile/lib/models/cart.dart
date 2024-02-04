import 'dart:convert';

import 'package:anime_dstore_mobile/models/Item.dart';
import 'package:anime_dstore_mobile/utils/index.dart';
import 'package:http/http.dart' as http;

class Cart {
  int quantity;
  final Item item;

  Cart({
    required this.quantity,
    required this.item,
  });
}

// Checkout
Future<bool> checkout(Set<Cart> carts, userId) async {
  if (carts.isEmpty) throw Exception('Cart is empty');

  final response = await http.post(
    Uri.parse('$externalApiUrl/api/checkout'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'carts': carts
          .map((item) => {
                'item_id': item.item.id,
                'quantity': item.quantity,
              })
          .toList(),
      'user_id': userId,
    }),
  );

  if (response.statusCode == 200) {
    return true;
  }
  throw Exception('Failed to checkout');
}
