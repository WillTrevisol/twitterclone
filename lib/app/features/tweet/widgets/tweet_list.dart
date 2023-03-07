import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitterclone/app/features/tweet/controller/tweet_controller.dart';
import 'package:twitterclone/app/features/tweet/widgets/tweet_card.dart';
import 'package:twitterclone/app/theme/pallete.dart';
import 'package:twitterclone/app/widgets/deafult_loading.dart';
import 'package:twitterclone/app/widgets/error_view.dart';

class TweetList extends ConsumerWidget {
  const TweetList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getTweetsProvider(context)).when(
      data: (data) {
        return ListView.separated(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            final tweet = data[index];
            return TweetCard(tweet: tweet);
          }, 
          separatorBuilder: (BuildContext context, int index) => const Divider(color: Pallete.greyColor),
        );
      }, 
      error: (error, stackTrace) => ErrorText(message: error.toString()), 
      loading: () => const DefaultLoading(),
    );
  }
}