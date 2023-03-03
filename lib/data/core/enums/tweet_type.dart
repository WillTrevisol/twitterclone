enum TweetType {
  text('text'),
  image('image'),
  gif('gif');

  final String type;
  const TweetType(this.type);
}

extension ConvertTweetType on String {
  TweetType toTweetTypeEnum() {
    switch (this) {
      case 'text':
        return TweetType.text;
      case 'image':
        return TweetType.image;
      case 'gif':
        return TweetType.gif;

      default:
        return TweetType.text;
    }
  }
}