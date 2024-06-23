import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_app/auth/repository/auth_repository.dart';

class AuthState {
  final bool isAuthenticated;

  AuthState({this.isAuthenticated = false});
}

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthViewModel(this._authRepository) : super(AuthState());

  Future<void> login(String email, String password) async {
    bool isAuthenticated = await _authRepository.login(email, password);
    if (isAuthenticated) {
      state = AuthState(isAuthenticated: true);
    } else {
      state = AuthState(isAuthenticated: false);
    }
  }
}

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
  (ref) => AuthViewModel(AuthRepository()),
);
