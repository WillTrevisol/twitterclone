import 'package:appwrite/models.dart';
import 'package:twitterclone/data/core/typedef.dart';
import 'package:twitterclone/domain/entities/tweet.dart';

abstract class ITweetRepository {

  FutureEither<Document> shareTweet(Tweet tweet);

}