import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitterclone/app/features/auth/controller/auth_controller.dart';
import 'package:twitterclone/data/core/enums/tweet_type.dart';
import 'package:twitterclone/data/core/utils.dart';
import 'package:twitterclone/data/repositories/storage_repository.dart';
import 'package:twitterclone/data/repositories/tweet_repository.dart';
import 'package:twitterclone/domain/entities/tweet.dart';

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
  }) {
    if (text.isEmpty) {
      showSnackBar(context: context, content: 'Please enter some message', isError: true);
      return;
    }

    if (images.isNotEmpty) {
      _shareImagesTweet(context: context, images: images, text: text);
      return;
    }

    _shareTextTweet(context: context, text: text);
  }

  void _shareImagesTweet({
    required BuildContext context,
    required List<File> images,
    required String text,
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
      type: TweetType.text, 
      createdAt: DateTime.now(), 
      reshareCount: 0,
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
}