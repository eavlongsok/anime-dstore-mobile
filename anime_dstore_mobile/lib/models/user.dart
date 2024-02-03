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
