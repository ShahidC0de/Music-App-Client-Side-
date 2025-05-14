import 'package:client_side/core/provider/current_user_notifier.dart';
import 'package:client_side/core/theme/theme.dart';
import 'package:client_side/features/auth/view/pages/sign_up.dart';
import 'package:client_side/features/auth/view_model/auth_viewmodel.dart';
import 'package:client_side/features/home/view/pages/home_page.dart';
import 'package:client_side/features/home/view/pages/upload_song_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  final notifier = container.read(authViewModelProvider.notifier);
  await notifier.initSharedPreferences();
  await notifier.getCurrentUserData();

  runApp(UncontrolledProviderScope(
    container: container,
    child: MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserNotifierProvider);
    return MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.darkThemeMode,
        home: currentUser == null ? SignUp() : UploadSongPage());
  }
}
