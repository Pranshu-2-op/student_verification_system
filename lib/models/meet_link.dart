// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MeetLinkModel {
  final String linkUID;
  final String link;
  final String subject;
  final String standard;
  final DateTime time;
  MeetLinkModel({
    required this.linkUID,
    required this.link,
    required this.subject,
    required this.standard,
    required this.time,
  });

  MeetLinkModel copyWith({
    String? linkUID,
    String? link,
    String? subject,
    String? standard,
    DateTime? time,
  }) {
    return MeetLinkModel(
      linkUID: linkUID ?? this.linkUID,
      link: link ?? this.link,
      subject: subject ?? this.subject,
      standard: standard ?? this.standard,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'linkUID': linkUID,
      'link': link,
      'subject': subject,
      'standard': standard,
      'time': time.millisecondsSinceEpoch,
    };
  }

  factory MeetLinkModel.fromMap(Map<String, dynamic> map) {
    return MeetLinkModel(
      linkUID: map['linkUID'] as String,
      link: map['link'] as String,
      subject: map['subject'] as String,
      standard: map['standard'] as String,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory MeetLinkModel.fromJson(String source) =>
      MeetLinkModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MeetLinkModel(linkUID: $linkUID, link: $link, subject: $subject, standard: $standard, time: $time)';
  }

  @override
  bool operator ==(covariant MeetLinkModel other) {
    if (identical(this, other)) return true;

    return other.linkUID == linkUID &&
        other.link == link &&
        other.subject == subject &&
        other.standard == standard &&
        other.time == time;
  }

  @override
  int get hashCode {
    return linkUID.hashCode ^
        link.hashCode ^
        subject.hashCode ^
        standard.hashCode ^
        time.hashCode;
  }
}
