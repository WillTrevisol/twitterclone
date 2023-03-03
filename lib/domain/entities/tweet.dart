import 'package:flutter/material.dart';
import 'package:twitterclone/data/core/enums/tweet_type.dart';

@immutable
class Tweet {

  final String id;
  final String userId;
  final String text;
  final String link;
  final List<String> hashtags;
  final List<String> imagesLinks;
  final List<String> likes;
  final List<String> comments;
  final TweetType type;
  final DateTime createdAt;
  final int reshareCount;
  const Tweet({
    required this.id,
    required this.userId,
    required this.text,
    required this.link,
    required this.hashtags,
    required this.imagesLinks,
    required this.likes,
    required this.comments,
    required this.type,
    required this.createdAt,
    required this.reshareCount,
  });


  Tweet copyWith({
    String? id,
    String? userId,
    String? text,
    String? link,
    List<String>? hashtags,
    List<String>? imagesLinks,
    List<String>? likes,
    List<String>? comments,
    TweetType? type,
    DateTime? createdAt,
    int? reshareCount,
  }) {
    return Tweet(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      text: text ?? this.text,
      link: link ?? this.link,
      hashtags: hashtags ?? this.hashtags,
      imagesLinks: imagesLinks ?? this.imagesLinks,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      reshareCount: reshareCount ?? this.reshareCount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'text': text,
      'link': link,
      'hashtags': hashtags,
      'imagesLinks': imagesLinks,
      'likes': likes,
      'comments': comments,
      'type': type.type,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'reshareCount': reshareCount,
    };
  }

  factory Tweet.fromMap(Map<String, dynamic> map) {
    return Tweet(
      id: map['\$id'] as String,
      userId: map['userId'] as String,
      text: map['text'] as String,
      link: map['link'] as String,
      hashtags: List<String>.from(map['hashtags']),
      imagesLinks: List<String>.from(map['imagesLinks']),
      likes: List<String>.from(map['likes']),
      comments: List<String>.from(map['comments']),
      type: (map['type'] as String).toTweetTypeEnum(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      reshareCount: map['reshareCount'] as int,
    );
  }

  @override
  String toString() {
    return 'Tweet(id: $id, userId: $userId, text: $text, link: $link, hashtags: $hashtags, imagesLinks: $imagesLinks, likes: $likes, comments: $comments, type: $type, createdAt: $createdAt, reshareCount: $reshareCount)';
  }
}
