import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:twitterclone/data/core/typedef.dart';
import 'package:twitterclone/domain/entities/tweet.dart';

abstract class ITweetRepository {

  FutureEither<Document> shareTweet(Tweet tweet);
  FutureEither<List<Document>> getTweets();
  Stream<RealtimeMessage> getLatestTweet();
  FutureEither<Document> likeTweet(Tweet tweet);
  FutureEither<Document> reshareCount(Tweet tweet);

}