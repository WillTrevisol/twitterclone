import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:twitterclone/app/features/auth/controller/auth_controller.dart';
import 'package:twitterclone/app/features/tweet/widgets/carousel_tweet_images.dart';
import 'package:twitterclone/app/features/tweet/widgets/hashtag_text.dart';
import 'package:twitterclone/app/features/tweet/widgets/tweet_icon_button.dart';
import 'package:twitterclone/app/theme/theme.dart';
import 'package:twitterclone/app/widgets/deafult_loading.dart';
import 'package:twitterclone/app/widgets/default_circle_avatar.dart';
import 'package:twitterclone/app/widgets/error_view.dart';
import 'package:twitterclone/data/constants/constants.dart';
import 'package:twitterclone/data/core/core.dart';
import 'package:twitterclone/domain/entities/tweet.dart';

class TweetCard extends ConsumerWidget {

  final Tweet tweet;

  const TweetCard({super.key, required this.tweet});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getUserDataProvider(tweet.userId)).when(
      data: (user) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Container(
              margin: const EdgeInsets.all(10),
              child: DefaultCircleAvatar(
                profilePicure: user.profilePicture, 
                radius: 35,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  // TODO: retweeted
                  Row(
                    children: <Widget> [
                      Container(
                        margin: const EdgeInsets.only(right: 5),
                        child: Text(
                          user.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        '@${getUserNickFromEmail(user.email)} • ${timeago.format(
                          tweet.createdAt,
                          locale: 'en_short', 
                        )}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Pallete.greyColor,
                        ),
                      ),
                    ],
                  ),
                  // TODO: Replied to
                  TweetText(text: tweet.text),
                    if (tweet.type == TweetType.image)
                      CarouselTweetImage(imageLinks: tweet.imagesLinks),

                    if (tweet.link.isNotEmpty) 
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: AnyLinkPreview(
                          link: 'https://${tweet.link}',
                          displayDirection: UIDirection.uiDirectionHorizontal,
                        ),
                      ),

                  Container(
                    margin: const EdgeInsets.only(top: 10, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget> [
                        TweetIconButton(
                          pathName: AssetsConstants.viewsIcon, 
                          text: (tweet.comments.length + tweet.reshareCount + tweet.likes.length).toString(),
                          onTap: () {},
                        ),
                        TweetIconButton(
                          pathName: AssetsConstants.commentIcon, 
                          text: tweet.comments.length.toString(), 
                          onTap: () {},
                        ),
                        TweetIconButton(
                          pathName: AssetsConstants.retweetIcon, 
                          text: tweet.reshareCount.toString(), 
                          onTap: () {},
                        ),
                        TweetIconButton(
                          pathName: AssetsConstants.likeOutlinedIcon, 
                          text: tweet.likes.length.toString(), 
                          onTap: () {},
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.share_outlined,
                            size: 22,
                            color: Pallete.greyColor,
                          )
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 1),
                ],
              ),
            ),
          ],
        );
      },
      error: (error, stackTrace) => ErrorText(message: error.toString()), 
      loading: () => const DefaultLoading(),
    );
  }
}