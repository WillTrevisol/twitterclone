import 'dart:developer';

import 'package:appwrite/models.dart' as model;
import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../domain/repositories/i_auth_repository.dart';
import '../core/core.dart';

final authRepositoryProvider = Provider(
  (ProviderRef ref) {
    final account = ref.watch(appWriteAccountProvider);
    return AuthRepository(account: account);
});

class AuthRepository implements IAuthRepository {
  final Account _account;

  AuthRepository({
    required Account account,
  }) : _account = account;

  @override
  FutureEither<model.Account> signUp({required String email, required String password, required String name}) async {
    try {

      final response = await _account.create(
        userId: ID.unique(), 
        email: email, 
        password: password,
        name: name,
      );

      return right(response);
    } on AppwriteException catch (e, stackTrace) {
      log(e.toString());
      return left(Failure(e.message ?? 'Unexpected error ocurred', stackTrace));
    } catch (e, stackTrace) {
      log(e.toString());
      return left(Failure(e.toString(), stackTrace));
    }
  }
  
  @override
  FutureEither<model.Session> login({required String email, required String password}) async {
    try {

      final response = await _account.createEmailSession(
        email: email, 
        password: password,
      );

      return right(response);
    } on AppwriteException catch (e, stackTrace) {
      log(e.toString());
      return left(Failure(e.message ?? 'Unexpected error ocurred', stackTrace));
    } catch (e, stackTrace) {
      log(e.toString());
      return left(Failure(e.toString(), stackTrace));
    }
  }
  
  @override
  Future<model.Account?> getCurrentUserAccount() async {
    try {
      return await _account.get();
    } on AppwriteException catch (e) {
      log(e.toString());
      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

}