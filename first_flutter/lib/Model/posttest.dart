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
  final double latitude;
  final double longitude;
  posttest({
    required this.pid,
    required this.uid,
    required this.postby,
    required this.heading,
    required this.location,
    required this.status,
    required this.text,
    required this.profileUrl,
    required this.latitude,
    required this.longitude,
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
    double? latitude,
    double? longitude,
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
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
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
      'latitude': latitude,
      'longitude': longitude,
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
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory posttest.fromJson(String source) => posttest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'posttest(pid: $pid, uid: $uid, postby: $postby, : $heading, location: $location, status: $status, text: $text, profileUrl: $profileUrl,latitude: $latitude,longitude: $longitude)';
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
      other.profileUrl == profileUrl &&
      other.latitude == latitude &&
      other.longitude == longitude;
      
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
      profileUrl.hashCode ^
      latitude.hashCode ^
      longitude.hashCode;
  }
}