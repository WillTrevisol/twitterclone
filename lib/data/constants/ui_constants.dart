import 'package:flutter/material.dart';
import 'package:twitterclone/app/features/tweet/widgets/tweet_list.dart';

class UIConstants {

  static List<Widget> homePages = const [
    TweetList(),
    Text('Search Screen'),
    Text('Notification Screen')
  ];
}