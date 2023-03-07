import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitterclone/data/constants/appwrite_constans.dart';
import 'package:twitterclone/data/core/core.dart';
import 'package:twitterclone/domain/entities/tweet.dart';
import 'package:appwrite/models.dart';
import 'package:twitterclone/domain/repositories/i_tweet_repository.dart';

final tweetRepositoryProvider = Provider(
  (ProviderRef ref) {
    final databases = ref.watch(appWriteDatabaseProvider);
    return TweetRepository(databases: databases);
});

class TweetRepository implements ITweetRepository {

  final Databases _databases;

  TweetRepository({
    required Databases databases,
  }) : _databases = databases;

  @override
  FutureEither<Document> shareTweet(Tweet tweet) async {
    try {
      final document = await _databases.createDocument(
        databaseId: AppWriteConstants.databaseId,
        collectionId: AppWriteConstants.tweetsColletionId,
        documentId: ID.unique(),
        data: tweet.toMap(),
      );

      return right(document);
    } on AppwriteException catch (error, stackTrace) {
      log(error.toString());

      return left(Failure(error.message ?? 'Some unexpected error ocurred.', stackTrace));
    } catch (error, stackTrace) {
      log(error.toString());

      return left(Failure(error.toString(), stackTrace));
    }
  }
  
  @override
  FutureEither<List<Document>> getTweets() async {
    try {
      final documents = await _databases.listDocuments(
      databaseId: AppWriteConstants.databaseId, 
      collectionId: AppWriteConstants.tweetsColletionId,
    );

    return right(documents.documents);
    } on AppwriteException catch (error, stackTrace) {
      log(error.toString());

      return left(Failure(error.message ?? 'Some unexpected error ocurred.', stackTrace));
    } catch (error, stackTrace) {
      log(error.toString());

      return left(Failure(error.toString(), stackTrace));
    }
    
  }

}