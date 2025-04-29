import 'package:client_side/features/auth/model/user_model.dart';
import 'package:client_side/features/auth/repositories/auth_local_repository.dart';
import 'package:client_side/features/auth/repositories/auth_remote_repositories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part "auth_viewmodel.g.dart";

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRemoteRepository _authRemoteRepository;
  late AuthLocalRepository _authLocalRepository;
  Future<void> initSharedPreferences() async {
    await _authLocalRepository.init();
  }

  @override
  AsyncValue<UserModel>? build() {
    _authRemoteRepository = ref.watch(authRemoteREpositoryProvider);
    // ignore: avoid_manual_providers_as_generated_provider_dependency
    _authLocalRepository = ref.watch(authLocalrepositoryProvider);
    return null;
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    final response = await _authRemoteRepository.signUp(
      name: name,
      email: email,
      password: password,
    );

    //    final val = switch (response) {
    //   Left(value: final l) => l,
    //   Right(value: final r) => r.toString(),
    // };
    state = response.fold(
        (l) => AsyncValue.error(l.message, StackTrace.current),
        (r) => AsyncValue.data(r));
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    final response = await _authRemoteRepository.login(
      email: email,
      password: password,
    );

    //    final val = switch (response) {
    //   Left(value: final l) => l,
    //   Right(value: final r) => r.toString(),
    // };
    state = response.fold(
        (l) => AsyncValue.error(l.message, StackTrace.current),
        (r) => _loginSuccess(r));
  }

  AsyncValue<UserModel>? _loginSuccess(UserModel user) {
    _authLocalRepository.setToken(user.token);
    return AsyncValue.data(user);
  }
}
