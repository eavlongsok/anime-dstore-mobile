import 'package:anime_dstore_mobile/models/item.dart';
import 'package:anime_dstore_mobile/models/item.dart';
import 'package:anime_dstore_mobile/utils/index.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
  final int id;
  final String email;

  const User({
    required this.id,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
    );
  }
}

class PurchaseHistory {
  final int id;
  final Item item;
  final int quantity;

  const PurchaseHistory({
    required this.id,
    required this.item,
    required this.quantity,
  });

  factory PurchaseHistory.fromJson(Map<String, dynamic> json) {
    return PurchaseHistory(
      id: json['id'],
      item: Item.fromJson(json['item']),
      quantity: json['quantity'],
    );
  }
}

User parseUser(String responseBody) {
  final parsed = jsonDecode(responseBody);
  return User.fromJson(parsed['data']['user']);
}

Future<User> login(String email, String password) async {
  final response = await http.get(
      Uri.parse('$externalApiUrl/api/login?email=$email&password=$password'));
  if (response.statusCode == 200) {
    return parseUser(response.body);
  }
  throw Exception('Failed to login user');
}

List<PurchaseHistory> parsePurchaseHistory(String responseBody) {
  final parsed = jsonDecode(responseBody);
  return parsed['data']['purchaseHistory']
      .map<PurchaseHistory>((json) => PurchaseHistory.fromJson(json))
      .toList();
}

Future<List<PurchaseHistory>> getPurchaseHistory(int userId) async {
  final response = await http.get(
      Uri.parse('$externalApiUrl/api/user/purchaseHistory?user_id=$userId'));
  if (response.statusCode == 200) {
    return parsePurchaseHistory(response.body);
  }
  throw Exception('Failed to get purchase history');
}

Future<bool> clearPurchaseHistory(int userId) async {
  final response = await http.post(Uri.parse(
      '$externalApiUrl/api/user/clearPurchaseHistory?user_id=$userId'));
  if (response.statusCode == 200) {
    return true;
  }
  throw Exception('Failed to clear purchase history');
}

Future<bool> changePassword(int userId, String newPassword) async {
  final response = await http.post(Uri.parse(
      '$externalApiUrl/api/user/changePassword?user_id=$userId&new_password=$newPassword'));
  if (response.statusCode == 200) {
    return true;
  }
  throw Exception('Failed to change password');
}

Future<bool> register(String email, String password) async {
  final response = await http.post(Uri.parse(
      '$externalApiUrl/api/register?email=$email&password=$password'));
  // log
  print('register user response body: ${response.body}');
  if (response.statusCode == 200) {
    return true;
  }

  return false;
}
