import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitterclone/app/features/auth/controller/auth_controller.dart';
import 'package:twitterclone/data/core/enums/tweet_type.dart';
import 'package:twitterclone/data/core/utils.dart';
import 'package:twitterclone/data/repositories/storage_repository.dart';
import 'package:twitterclone/data/repositories/tweet_repository.dart';
import 'package:twitterclone/domain/entities/tweet.dart';
import 'package:twitterclone/domain/entities/user.dart';

final tweetControllerProvider = StateNotifierProvider<TweetController, bool>(
  (StateNotifierProviderRef ref) {
    final tweetRepository = ref.watch(tweetRepositoryProvider);
    final storageRepository = ref.watch(storageRepositoryProvider);
    return TweetController(
      ref: ref, 
      tweetRepository: tweetRepository,
      storageRepository: storageRepository,
    );
});

final getTweetsProvider = FutureProvider.family(
  (FutureProviderRef ref, BuildContext context) async {
    final tweetController = ref.watch(tweetControllerProvider.notifier);
    return tweetController.getTweets(context);
});

final getLatestTweetProvider = StreamProvider.autoDispose(
  (StreamProviderRef ref) {
    final tweetRepository = ref.watch(tweetRepositoryProvider);
    return tweetRepository.getLatestTweet();
});

class TweetController extends StateNotifier<bool> {
  TweetController({
    required Ref ref,
    required TweetRepository tweetRepository,
    required StorageRepository storageRepository,
  }): 
    _ref = ref,
    _tweetRepository = tweetRepository,
    _storageRepository = storageRepository,
    super(false);
  
  final Ref _ref;
  final TweetRepository _tweetRepository;
  final StorageRepository _storageRepository;

  void shareTweet({
    required BuildContext context,
    required List<File> images,
    required String text,
    required String repliedTo,
  }) {
    if (text.isEmpty) {
      showSnackBar(context: context, content: 'Please enter some message', isError: true);
      return;
    }

    if (images.isNotEmpty) {
      _shareImagesTweet(context: context, images: images, text: text, repliedTo: repliedTo);
      return;
    }

    _shareTextTweet(context: context, text: text, repliedTo: repliedTo);
  }

  void _shareImagesTweet({
    required BuildContext context,
    required List<File> images,
    required String text,
    required String repliedTo,
  }) async {
    state = true;

    List<String> imagesLinks = [];
    final hashtags = _getHashtagsFromText(text);
    final link = _getLinkFromText(text);
    final userId = _ref.read(currentUserDataProvider).value;
    final imagesResponse = await _storageRepository.storeImages(images);
    
    imagesResponse.fold(
      (left) {
        showSnackBar(context: context, content: left.message, isError: true);
        return;
      }, 
      (right) => imagesLinks = right,
    );

    Tweet tweet = Tweet(
      id: '', 
      userId: userId?.id??'',
      text: text,
      link: link,
      hashtags: hashtags,
      imagesLinks: imagesLinks, 
      likes: const [], 
      comments: const [], 
      type: TweetType.image, 
      createdAt: DateTime.now(), 
      reshareCount: 0,
      retweetedBy: '',
      repliedTo: repliedTo,
    );

    final response = await _tweetRepository.shareTweet(tweet);

    response.fold(
      (left) => showSnackBar(context: context ,content: left.message, isError: true), 
      (right) => null,
    );
    state = false;
  }

  void _shareTextTweet({
    required BuildContext context,
    required String text,
    required String repliedTo,
  }) async {
    state = true;

    final hashtags = _getHashtagsFromText(text);
    final link = _getLinkFromText(text);
    final userId = _ref.read(currentUserDataProvider).value;

    Tweet tweet = Tweet(
      id: '', 
      userId: userId?.id??'',
      text: text,
      link: link,
      hashtags: hashtags,
      imagesLinks: const [], 
      likes: const [], 
      comments: const [], 
      type: TweetType.text, 
      createdAt: DateTime.now(), 
      reshareCount: 0,
      retweetedBy: '',
      repliedTo: repliedTo,
    );

    final response = await _tweetRepository.shareTweet(tweet);

    response.fold(
      (left) => showSnackBar(context: context ,content: left.message, isError: true), 
      (right) => null,
    );
    state = false;
  }

  String _getLinkFromText(String text) {
    String link = '';
    List<String> wordsInSentence = text.split(' ');
    for (final word in wordsInSentence) {
      if (word.startsWith('https://') || word.startsWith('www.')) {
        link = word;
      }
    }

    return link;
  }

  List<String> _getHashtagsFromText(String text) {
    List<String> hashtags = [];
    List<String> wordsInSentence = text.split(' ');
    for (final word in wordsInSentence) {
      if (word.startsWith('#')) {
        hashtags.add(word);
      }
    }

    return hashtags;
  }

  Future<List<Tweet>> getTweets(BuildContext context) async {
    List<Tweet> tweets = [];
    final response = await _tweetRepository.getTweets();

    response.fold(
      (left) => showSnackBar(context: context, content: left.message, isError: true), 
      (right) {
        tweets = right.map((tweet) => Tweet.fromMap(tweet.data)).toList();
      },
    );

    return tweets;
  }

  Future<List<Tweet>> getTweetComments(BuildContext context, Tweet tweet) async {
    List<Tweet> tweets = [];
    final response = await _tweetRepository.getTweetComments(tweet);

    response.fold(
      (left) => showSnackBar(context: context, content: left.message, isError: true), 
      (right) {
        tweets = right.map((tweet) => Tweet.fromMap(tweet.data)).toList();
      },
    );

    return tweets;
  }

  void likeTweet({required BuildContext context, required Tweet tweet, required User user}) async {
    List<String> likes = tweet.likes;

    if (tweet.likes.contains(user.id)) {
      likes.remove(user.id);
    } else {
      likes.add(user.id);
    }

    tweet = tweet.copyWith(
      likes: likes,
    );

    final response = await _tweetRepository.likeTweet(tweet);
    response.fold(
      (left) => null, 
      (right) => null,
    );
  }

  void reshareTweet({
    required BuildContext context, 
    required Tweet tweet, 
    required User user,
  }) async {
    tweet = tweet.copyWith(
      retweetedBy: user.name,
      likes: [],
      comments: [],
      reshareCount: tweet.reshareCount + 1,
    );

    final response = await _tweetRepository.reshareCount(tweet);
    response.fold(
      (left) => showSnackBar(context: context, content: left.message, isError: true), 
      (right) async {
        tweet = tweet.copyWith(
          id: ID.unique(),
          reshareCount: 0,
          createdAt: DateTime.now(),
        );
        final retweetResponse = await _tweetRepository.shareTweet(tweet);

        retweetResponse.fold(
          (left) => showSnackBar(context: context, content: left.message, isError: true), 
          (right) => showSnackBar(context: context, content: 'Retweeted :D'),
        );
      },
    );
  }


}
