import 'package:appwrite/models.dart';
import 'package:twitterclone/data/core/typedef.dart';

import '../entities/user.dart';

abstract class IUserRepository {
  FutureEitherVoid saveUserData(User user);
  Future<Document> getUserData(String id);
}