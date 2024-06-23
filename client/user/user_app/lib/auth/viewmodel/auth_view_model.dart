import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_app/auth/repository/auth_repository.dart';

class AuthState {
  final bool isAuthenticated;
  final Map<String, dynamic>? userProfile;
  final String? userId;

  AuthState({
    this.isAuthenticated = false,
    this.userProfile,
    this.userId,
  });
}

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthViewModel(this._authRepository) : super(AuthState());

  Future<void> login(String email, String password) async {
    final userId = await _authRepository.login(email, password);
    if (userId != null) {
      state = AuthState(isAuthenticated: true, userId: userId);
      await fetchProfile(userId);
    } else {
      state = AuthState(isAuthenticated: false);
    }
  }

  Future<void> fetchProfile(String userId) async {
    try {
      final userProfile = await _authRepository.fetchProfile(userId);
      if (userProfile != null) {
        state = AuthState(isAuthenticated: state.isAuthenticated, userProfile: userProfile, userId: userId);
        print('Profile fetched: $userProfile');
      }
    } catch (e) {
      print('Fetch profile error: $e');
    }
  }

  void logout() {
    state = AuthState(isAuthenticated: false);
  }
}

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
  (ref) => AuthViewModel(AuthRepository()),
);







// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:user_app/auth/repository/auth_repository.dart';

// class AuthState {
//   final bool isAuthenticated;
//   final Map<String, dynamic>? userProfile;

//   AuthState({
//     this.isAuthenticated = false,
//     this.userProfile,
//   });
// }

// class AuthViewModel extends StateNotifier<AuthState> {
//   final AuthRepository _authRepository;

//   AuthViewModel(this._authRepository) : super(AuthState());

//   Future<void> login(String email, String password) async {
//     bool isAuthenticated = await _authRepository.login(email, password);
//     if (isAuthenticated) {
//       final userProfile = await _authRepository.fetchProfile();
//       state = AuthState(isAuthenticated: true, userProfile: userProfile);
//     } else {
//       state = AuthState(isAuthenticated: false);
//     }
//   }

//   Future<void> fetchProfile() async {
//     try {
//       final userProfile = await _authRepository.fetchProfile();
//       state = AuthState(isAuthenticated: true, userProfile: userProfile);
//     } catch (e) {
//       // Handle fetch profile error
//     }
//   }

//   void logout() {
//     state = AuthState(isAuthenticated: false);
//   }
// }

// final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
//   (ref) => AuthViewModel(AuthRepository()),
// );





// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:user_app/auth/repository/auth_repository.dart';

// class AuthState {
//   final bool isAuthenticated;

//   AuthState({this.isAuthenticated = false});
// }

// class AuthViewModel extends StateNotifier<AuthState> {
//   final AuthRepository _authRepository;

//   AuthViewModel(this._authRepository) : super(AuthState());

//   Future<void> login(String email, String password) async {
//     bool isAuthenticated = await _authRepository.login(email, password);
//     if (isAuthenticated) {
//       state = AuthState(isAuthenticated: true);
//     } else {
//       state = AuthState(isAuthenticated: false);
//     }
//   }
// }

// final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
//   (ref) => AuthViewModel(AuthRepository()),
// );
