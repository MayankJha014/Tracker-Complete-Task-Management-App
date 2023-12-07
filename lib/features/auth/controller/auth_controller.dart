import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/core/common/failure.dart';
import 'package:tracker/core/contants/utils.dart';
import 'package:tracker/features/auth/repository/auth_repository.dart';
import 'package:tracker/model/user_model.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
      authRepository: ref.read(authRepositoryProvider), ref: ref),
);

final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

final getUserDataProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;

  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false);

  Stream<User?> get authStateChange => _authRepository.authStateChange;

  void signWithGoogle(final BuildContext context) async {
    try {
      state = true;
      final user = await _authRepository.signWithGoogle();
      user.fold((l) => Failure(l.message),
          (r) => _ref.read(userProvider.notifier).update((state) => r));
    } catch (e) {
      showSnackBar(context, "An error occurred: $e");
    } finally {
      state = false;
    }
  }

  void logout() {
    _authRepository.logout();
  }

  Stream<UserModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }
}
