
import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/i_user_repository.dart';
import '../constants/constants.dart';
import '../core/core.dart';

final userRepositoryProvider = Provider(
  (ProviderRef ref) {
    return UserRepository(database: ref.watch(appWriteDatabaseProvider));
  }
);

class UserRepository implements IUserRepository {

  UserRepository({required Databases database}) : _database = database;

  final Databases _database;

  @override
  FutureEitherVoid saveUserData(User user) async {
    try {
      await _database.createDocument(
        databaseId: AppWriteConstants.databaseId, 
        collectionId: AppWriteConstants.usersCollectionId, 
        documentId: user.id, 
        data: user.toMap(),
      );

      return right(null);
    } on AppwriteException catch (e, stackTrace) {
      log(e.toString());
      return left(Failure(e.message ?? 'Unexpected error ocurred', stackTrace));
    } catch (e, stackTrace) {
      log(e.toString());
      return left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  Future<Document> getUserData(String id) {
    return _database.getDocument(
      databaseId: AppWriteConstants.databaseId, 
      collectionId: AppWriteConstants.usersCollectionId, 
      documentId: id,
    );
  }

}