import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_app/auth/viewmodel/auth_view_model.dart';
import 'package:user_app/auth/view/login_screen.dart';
// import 'package:user_app/home/view/home_screen.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authViewModel = ref.watch(authViewModelProvider);

    return MaterialApp(
      home: authViewModel.isAuthenticated ? HomeScreen() : LoginScreen(),
    );
  }
}
