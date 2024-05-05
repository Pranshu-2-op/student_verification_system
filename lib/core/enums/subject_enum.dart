enum TweetType {
  bst('bst'),
  english('english');
  // english('english');

  final String type;
  const TweetType(this.type);
}

// 'text'.toEnum()
// TweetType.text
extension ConvertTweet on String {
  TweetType toTweetTypeEnum() {
    switch (this) {
      case 'english':
        return TweetType.english;
      case 'bst':
        return TweetType.bst;
      default:
        return TweetType.english;
    }
  }
}
