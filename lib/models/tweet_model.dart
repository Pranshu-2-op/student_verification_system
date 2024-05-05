// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// import 'package:flutter/foundation.dart';

// import 'package:twitter_clone/core/enums/tweet_type_enum.dart';

// @immutable
// class TweetModel {
//   final String text;
//   final List<String> hashtags;
//   final String link;
//   final List<String> imageLinks;
//   final String uid;
//   final TweetType tweetType;
//   final DateTime tweetedAt;
//   final List<String> likes;
//   final List<String> commentIds;
//   final Map<String, String> repostBy;
//   final String id;
//   final String repostedBy;
//   const TweetModel({
//     required this.text,
//     required this.hashtags,
//     required this.link,
//     required this.imageLinks,
//     required this.uid,
//     required this.tweetType,
//     required this.tweetedAt,
//     required this.likes,
//     required this.commentIds,
//     required this.repostBy,
//     required this.id,
//     required this.repostedBy,
//   });

//   TweetModel copyWith({
//     String? text,
//     List<String>? hashtags,
//     String? link,
//     List<String>? imageLinks,
//     String? uid,
//     TweetType? tweetType,
//     DateTime? tweetedAt,
//     List<String>? likes,
//     List<String>? commentIds,
//     Map<String, String>? repostBy,
//     String? id,
//     String? repostedBy,
//   }) {
//     return TweetModel(
//       text: text ?? this.text,
//       hashtags: hashtags ?? this.hashtags,
//       link: link ?? this.link,
//       imageLinks: imageLinks ?? this.imageLinks,
//       uid: uid ?? this.uid,
//       tweetType: tweetType ?? this.tweetType,
//       tweetedAt: tweetedAt ?? this.tweetedAt,
//       likes: likes ?? this.likes,
//       commentIds: commentIds ?? this.commentIds,
//       repostBy: repostBy ?? this.repostBy,
//       id: id ?? this.id,
//       repostedBy: repostedBy ?? this.repostedBy,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'text': text,
//       'hastags': hashtags,
//       'link': link,
//       'imageLinks': imageLinks,
//       'uid': uid,
//       'tweetType': tweetType.type,
//       'tweetedAt': tweetedAt.millisecondsSinceEpoch,
//       'likes': likes,
//       'commentIds': commentIds,
//       'repostBy': repostBy,
//       'id': id,
//       'repostedBy': repostedBy,
//     };
//   }

//   factory TweetModel.fromMap(Map<String, dynamic> map) {
//     return TweetModel(
//       text: map['text'] as String,
//       hashtags: (map['hashtags'] as List<dynamic>?)
//               ?.map((item) => item.toString())
//               .toList() ??
//           [],
//       link: map['link'] as String,
//       imageLinks: (map['imageLinks'] as List<dynamic>?)
//               ?.map((item) => item.toString())
//               .toList() ??
//           [],
//       uid: map['uid'] as String,
//       tweetType: (map['tweetType'] as String).toTweetTypeEnum(),
//       tweetedAt:
//           DateTime.fromMillisecondsSinceEpoch(map['tweetedAt'] as int? ?? 0),
//       likes: (map['likes'] as List<dynamic>?)
//               ?.map((item) => item.toString())
//               .toList() ??
//           [],
//       commentIds: (map['commentIds'] as List<dynamic>?)
//               ?.map((item) => item.toString())
//               .toList() ??
//           [],
//       id: map['id'] as String? ?? '',
//       repostBy: (map['repostBy'] as Map<String, dynamic>?)?.map(
//               (key, value) => MapEntry(key.toString(), value.toString())) ??
//           {},

//       // repostBy: {},
//       // id: '',
//       repostedBy: map['repostedBy'] as String? ?? '',
//       // repostBy: map['repostBy'] as Map<String, String>? ?? {},
//       // repostBy: (map['repostBy'] as Map<String, String>?)
//       // text: map['text'] as String? ?? '',
//       // hastags: List<String>.from((map['hastags'] as List<dynamic>? ?? [])),
//       // link: map['link'] as String? ?? '',
//       // imageLinks: List<String>.from((map['imageLinks'] as List<String>)),
//       // uid: map['uid'] as String? ?? '',
//       // tweetType:
//       //     map['tweetType'] == TweetType.text ? TweetType.text : TweetType.image,
//       // tweetedAt: DateTime.fromMillisecondsSinceEpoch(map['tweetedAt'] as int),
//       // likes: List<String>.from((map['likes'] as List<String>? ?? [])),
//       // commentIds: List<String>.from((map['commentIds'] as List<String>? ?? [])),
//       // repostBy: map['repostBy'] as Map<String, String>? ?? {},
//       // id: map['id'] as String? ?? '',
//       // repostedBy: map['repostedBy'] as String? ?? '',
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory TweetModel.fromJson(String source) =>
//       TweetModel.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() {
//     return 'TweetModel(text: $text, hashtags: $hashtags, link: $link, imageLinks: $imageLinks, uid: $uid, tweetType: $tweetType, tweetedAt: $tweetedAt, likes: $likes, commentIds: $commentIds, repostBy: $repostBy, id: $id, repostedBy: $repostedBy)';
//   }

//   @override
//   bool operator ==(covariant TweetModel other) {
//     if (identical(this, other)) return true;

//     return other.text == text &&
//         listEquals(other.hashtags, hashtags) &&
//         other.link == link &&
//         listEquals(other.imageLinks, imageLinks) &&
//         other.uid == uid &&
//         other.tweetType == tweetType &&
//         other.tweetedAt == tweetedAt &&
//         listEquals(other.likes, likes) &&
//         listEquals(other.commentIds, commentIds) &&
//         mapEquals(other.repostBy, repostBy) &&
//         other.id == id &&
//         other.repostedBy == repostedBy;
//   }

//   @override
//   int get hashCode {
//     return text.hashCode ^
//         hashtags.hashCode ^
//         link.hashCode ^
//         imageLinks.hashCode ^
//         uid.hashCode ^
//         tweetType.hashCode ^
//         tweetedAt.hashCode ^
//         likes.hashCode ^
//         commentIds.hashCode ^
//         repostBy.hashCode ^
//         id.hashCode ^
//         repostedBy.hashCode;
//   }
// }
