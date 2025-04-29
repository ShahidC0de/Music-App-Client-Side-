import 'dart:convert';
import 'package:client_side/core/constants/server_constants.dart';
import 'package:client_side/core/failure/failure.dart';
import 'package:client_side/features/auth/model/user_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_remote_repositories.g.dart';

@riverpod
AuthRemoteRepository authRemoteREpository(AuthRemoteREpositoryRef ref) {
  return AuthRemoteRepository();
}

class AuthRemoteRepository {
  Future<Either<Failure, UserModel>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ServerConstants.serverURL}/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );
      final user = await jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 201) {
        return left(Failure(user['detail']));
      }
      return right(UserModel.fromMap(user));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response =
          await http.post(Uri.parse('${ServerConstants.serverURL}/auth/login'),
              headers: {
                'Content-Type': 'application/json',
              },
              body: jsonEncode({
                'email': email,
                'password': password,
              }));
      final user = await jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        return left(Failure(user['detail']));
      }
      return right(UserModel.fromMap(user));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
