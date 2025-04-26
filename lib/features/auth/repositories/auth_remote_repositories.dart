import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthRemoteRepository {
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.226.114:8000/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );
      print('Request Body: ${jsonEncode({
            'name': name,
            'email': email,
            'password': password,
          })}'); // Add this line to check the request body

      print(response.body);
      print(response.statusCode);
    } catch (e) {
      print(e);
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      final response =
          await http.post(Uri.parse('http://192.168.226.114:8000/auth/login'),
              headers: {
                'Content-Type': 'application/json',
              },
              body: jsonEncode({
                'email': email,
                'password': password,
              }));
      print(response.body);
    } catch (e) {
      print(e);
    }
  }
}
