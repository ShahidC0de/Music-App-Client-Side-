import 'package:client_side/features/auth/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'current_user_notifier.g.dart';
// flutter pub run build_runner build --delete-conflicting-outputs
// to generate the riverpod class for any notifier, make sure u have needed dependencies in pubspec.yml file.
// and then run the above command.

@Riverpod(keepAlive: true)
class CurrentUserNotifier extends _$CurrentUserNotifier {
  @override
  UserModel? build() {
    return null;
  }

  void addUser(UserModel user) {
    state = user;
  }
}
