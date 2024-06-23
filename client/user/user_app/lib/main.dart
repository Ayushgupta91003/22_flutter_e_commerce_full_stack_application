import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_app/auth/view/login_screen.dart';
import 'package:user_app/home/view/home_screen.dart';
import 'package:user_app/auth/viewmodel/auth_view_model.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dio Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Consumer(
        builder: (context, ref, child) {
          final authState = ref.watch(authViewModelProvider);
          return authState.isAuthenticated ? HomeScreen() : LoginScreen();
        },
      ),
    );
  }
}
