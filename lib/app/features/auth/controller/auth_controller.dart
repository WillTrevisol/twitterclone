import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/core/utils.dart';
import '../../../../data/repositories/auth_repository.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (StateNotifierProviderRef ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    return AuthController(authRepository: authRepository);
  }
);

class AuthController extends StateNotifier<bool> {
  AuthController({required AuthRepository authRepository}) : _authRepository = authRepository, super(false);

  final AuthRepository _authRepository;

  void signUp({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    state = true;
    final response = await _authRepository.signUp(email: email, password: password, name: name);
    state = false;
    response.fold(
      (left) => showSnackBar(context: context, content: left.message, isError: true),
      (right) => log(right.toString()),
    );
  }

  void login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    state = true;
    final response = await _authRepository.login(email: email, password: password);
    state = false;
    response.fold(
      (left) => showSnackBar(context: context, content: left.message, isError: true),
      (right) => log(right.userId),
    );
  }

}