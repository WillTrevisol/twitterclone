import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/models.dart' as model;

import '../../../../data/core/utils.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../../data/repositories/user_repository.dart';
import '../../../../domain/entities/user.dart';
import '../../home/view/home_view.dart';
import '../view/login_view.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (StateNotifierProviderRef ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    final userRepository = ref.watch(userRepositoryProvider);
    return AuthController(authRepository: authRepository, userRepository: userRepository);
  }
);

final currentUserAccoutProvider = FutureProvider(
  (FutureProviderRef ref) async {
    final authController = ref.watch(authControllerProvider.notifier);
    return authController.getCurrentUserAccount();
  },
);

final currentUserDataProvider = FutureProvider(
  (FutureProviderRef ref) {
    final currentUserId = ref.watch(currentUserAccoutProvider).value?.$id;
    final userData = ref.watch(getUserDataProvider(currentUserId??''));
    return userData.value;
  },
);

final getUserDataProvider = FutureProvider.family(
  (FutureProviderRef ref, String id) async {
    final authController = ref.watch(authControllerProvider.notifier);
    return authController.getUserData(id);
  },
);

class AuthController extends StateNotifier<bool> {
  AuthController({
    required AuthRepository authRepository, 
    required UserRepository userRepository,
  }) : 
  _authRepository = authRepository, 
  _userRepository = userRepository,
  super(false);

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

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
      (right) async {
        User user = User(
          id: right.$id,
          email: email,
          name: name,
          profilePicture: '', 
          bannerPicture: '', 
          bioDescription: '', 
          isTwitterBlue: false,
          followers: [],
          following: [],
        );
        final userResponse = await _userRepository.saveUserData(user);

        userResponse.fold(
          (left) => showSnackBar(context: context, content: left.message, isError: true),
          (_) {
            showSnackBar(context: context, content: 'Account created! :D');
            Navigator.push(context, LoginView.route());
          } ,
        );
      },
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
      (right) => Navigator.push(context, HomeView.route()),
    );
  }

  Future<model.Account?> getCurrentUserAccount() => _authRepository.getCurrentUserAccount();

  Future<User> getUserData(String id) async {
    final document = await _userRepository.getUserData(id);
    final user = User.fromMap(document.data);
    return user;
  }

}