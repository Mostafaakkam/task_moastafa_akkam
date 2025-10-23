import 'dart:convert';

import '../model/auth_model.dart';
import 'package:http/http.dart' as http;

class AuthRepo {
  Future<AuthModel> register({
    required int id,
    required String username,
    required String email,
    required String password,
  }) async {
    // Note: http.post(body: Map<String, String>) casts values to String.
    // Passing non-String (e.g., int) causes a runtime type error.
    // We send JSON body instead to avoid the error and match FakeStoreAPI.
    final response = await http.post(
      Uri.parse('https://fakestoreapi.com/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "id": id,
        "username": username,
        "email": email,
        "password": password,
      }),
    );
    print(response.body);
    return AuthModel().fromJson(json.decode(response.body));
  }

  Future<AuthModel> login({
    required String username,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('https://fakestoreapi.com/auth/login'),
      body: {
        "username": username,
        "password": password,
      },
    );
    return AuthModel().fromJson(json.decode(response.body));
  }
}
