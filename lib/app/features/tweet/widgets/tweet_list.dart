import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitterclone/app/features/tweet/controller/tweet_controller.dart';
import 'package:twitterclone/app/features/tweet/widgets/tweet_card.dart';
import 'package:twitterclone/app/theme/pallete.dart';
import 'package:twitterclone/app/widgets/deafult_loading.dart';
import 'package:twitterclone/app/widgets/error_view.dart';
import 'package:twitterclone/data/constants/appwrite_constans.dart';
import 'package:twitterclone/domain/entities/tweet.dart';

class TweetList extends ConsumerWidget {
  const TweetList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getTweetsProvider(context)).when(
      data: (tweets) {

        return ref.watch(getLatestTweetProvider).when(
          data: (data) {
            if (data.events.contains(
              'databases.*.collections.${AppWriteConstants.tweetsColletionId}.documents.*.create')) {
                tweets.insert(0, Tweet.fromMap(data.payload));
            }

            return ListView.separated(
              itemCount: tweets.length,
              itemBuilder: (BuildContext context, int index) {
                final tweet = tweets[index];
                return TweetCard(tweet: tweet);
              }, 
              separatorBuilder: (BuildContext context, int index) => 
                Divider(
                  color: Pallete.greyColor.withOpacity(0.6),
                  indent: 8,
                  endIndent: 8,
                ),
            );
          }, 
          error: (error, stakTrace) => ErrorText(message: error.toString()), 
          loading: () => ListView.separated(
            itemCount: tweets.length,
            itemBuilder: (BuildContext context, int index) {
              final tweet = tweets[index];
              return TweetCard(tweet: tweet);
            }, 
            separatorBuilder: (BuildContext context, int index) => 
              Divider(
                color: Pallete.greyColor.withOpacity(0.6),
                indent: 8,
                endIndent: 8,
              ),
          ),
        );
      }, 
      error: (error, stackTrace) => ErrorText(message: error.toString()), 
      loading: () => const DefaultLoading(),
    );
  }
}