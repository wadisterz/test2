// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class posttest {

  final String pid;
  final String uid;
  final String postby;
  final String heading ; 
  final String location;
  final bool status;
  final String text;
  final String profileUrl;
  posttest({
    required this.pid,
    required this.uid,
    required this.postby,
    required this.heading,
    required this.location,
    required this.status,
    required this.text,
    required this.profileUrl,
  });

  posttest copyWith({
    String? pid,
    String? uid,
    String? postby,
    String? heading ,
    String? location,
    bool? status,
    String? text,
    String? profileUrl,
  }) {
    return posttest(
      pid: pid ?? this.pid,
      uid: uid ?? this.uid,
      postby: postby ?? this.postby,
      heading: heading ?? this.heading,
      location: location ?? this.location,
      status: status ?? this.status,
      text: text ?? this.text,
      profileUrl: profileUrl ?? this.profileUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pid': pid,
      'uid': uid,
      'postby': postby,
      'heading': heading,
      'location': location,
      'status': status,
      'text': text,
      'profileUrl': profileUrl,
    };
  }

  factory posttest.fromMap(Map<String, dynamic> map) {
    return posttest(
      pid: map['pid'] as String,
      uid: map['uid'] as String,
      postby: map['postby'] as String,
      heading: map['heading']as String,
      location: map['location'] as String,
      status: map['status'] as bool,
      text: map['text'] as String,
      profileUrl: map['profileUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory posttest.fromJson(String source) => posttest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'posttest(pid: $pid, uid: $uid, postby: $postby, : $heading, location: $location, status: $status, text: $text, profileUrl: $profileUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is posttest &&
      other.pid == pid &&
      other.uid == uid &&
      other.postby == postby &&
      other.heading == heading  &&
      other.location == location &&
      other.status == status &&
      other.text == text &&
      other.profileUrl == profileUrl;
  }

  @override
  int get hashCode {
    return pid.hashCode ^
      uid.hashCode ^
      postby.hashCode ^
      heading.hashCode ^
      location.hashCode ^
      status.hashCode ^
      text.hashCode ^
      profileUrl.hashCode;
  }
}
