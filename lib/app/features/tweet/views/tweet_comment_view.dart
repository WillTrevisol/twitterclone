import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitterclone/app/features/tweet/controller/tweet_controller.dart';
import 'package:twitterclone/app/features/tweet/widgets/tweet_card.dart';
import 'package:twitterclone/domain/entities/tweet.dart';

class TweetCommentView extends ConsumerWidget {
  static route({required Tweet tweet}) => MaterialPageRoute(
    builder: (context) => TweetCommentView(tweet: tweet),
  );
  final Tweet tweet;
  const TweetCommentView({super.key, required this.tweet});

  void onSubmittedReply(BuildContext context, WidgetRef ref, String text) {
    ref.read(tweetControllerProvider.notifier).shareTweet(
      context: context, 
      images: [], 
      text: text,
      repliedTo: tweet.id,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tweet'),
      ),
      body: Column(
        children: <Widget> [
          TweetCard(
            tweet: tweet,
          ),
        ],
      ),
      bottomNavigationBar: TextField(
        onSubmitted: (value) {
          onSubmittedReply(context, ref, value);
        },
        decoration: const InputDecoration(
          hintText: 'Tweet your reply'
        ),
      ),
    );
  }
}