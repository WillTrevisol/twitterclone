import 'package:appwrite/models.dart' as model;

import '../../data/core/core.dart';

abstract class IAuthRepository {
  FutureEither<model.Account> signUp({required String email, required String password, required String name});
  FutureEither<model.Session> login({required String email, required String password});
}