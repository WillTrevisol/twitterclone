import 'package:flutter/material.dart';
import 'package:twitterclone/app/theme/theme.dart';

class TweetText extends StatelessWidget {
  final String text;

  const TweetText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    List<TextSpan> textSpans = [];

    text.split(' ').forEach((element) {
      if (element.startsWith('#')) {
        textSpans.add(
          TextSpan(
            text: '$element ',
            style: const TextStyle(
              color: Pallete.blueColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
        return;
      }

      if (element.startsWith('www.') || element.startsWith('https://')) {
        textSpans.add(
          TextSpan(
            text: '$element ',
            style: const TextStyle(
              color: Pallete.blueColor,
              fontSize: 18,
            ),
          ),
        );
        return;
      }

      textSpans.add(
        TextSpan(
          text: '$element ',
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      );
    });

    return RichText(
      text: TextSpan(
        children: textSpans,
      ),
    );
  }
}