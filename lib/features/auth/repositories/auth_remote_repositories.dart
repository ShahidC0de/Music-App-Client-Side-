import 'dart:convert';
import 'package:client_side/core/failure/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

class AuthRemoteRepository {
  Future<Either<Failure, Map<String, dynamic>>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.124.114:8000/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode != 201) {
        return left(Failure(response.body));
      }
      final user = await jsonDecode(response.body) as Map<String, dynamic>;
      return right(user);
    } catch (e) {
      return left(Failure(e.toString()));
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
