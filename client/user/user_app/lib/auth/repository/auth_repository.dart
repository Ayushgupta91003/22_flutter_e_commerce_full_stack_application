// lib/auth/repository/auth_repository.dart

import 'package:dio/dio.dart';
import 'package:user_app/core/network/dio_client.dart';

class AuthRepository {
  Future<bool> login(String email, String password) async {
    try {
      final response = await dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        // If login is successful, you can store the token or handle the response accordingly
        // For now, just return true indicating success
        return true;
      } else {
        // Handle error response
        print('Login failed with status: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }
}
