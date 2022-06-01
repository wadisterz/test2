// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class UserModel2 {
   String? uid;
   String? username ; 
   String? password;
   String? email;
   String? bio;
   String? profileUrl;
   int? rate = 0;
   int? succeedcount = 0;
  UserModel2({
    this.uid,
    this.username,
    this.password,
    this.email,
    this.bio,
    this.profileUrl,
    this.rate,
    this.succeedcount,
  });

  UserModel2 copyWith({
    String? uid,
    String? username ,
    String? password,
    String? email,
    String? bio,
    String? profileUrl,
    int? rate,
    int? succeedcount,
  }) {
    return UserModel2(
      uid: uid?? this.uid,
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      profileUrl: profileUrl ?? this.profileUrl,
      rate: rate ?? this.rate,
      succeedcount: succeedcount ?? this.succeedcount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'username': username,
      'password': password,
      'email': email,
      'bio': bio,
      'profileUrl': profileUrl,
      'rate': rate,
      'succeedcount': succeedcount,
    };
  }

  factory UserModel2.fromMap(Map<String, dynamic> map) {
    return UserModel2(
      uid: map['uid'] != null ? map['uid'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      bio: map['bio'] != null ? map['bio'] as String : null,
      profileUrl: map['profileUrl'] != null ? map['profileUrl'] as String : null,
      rate: map['rate'] != null ? map['rate'] as int : null,
      succeedcount: map['succeedcount'] != null ? map['succeedcount'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel2.fromJson(String source) => UserModel2.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid, username: $username, password: $password, email: $email, bio: $bio, profileUrl: $profileUrl, rate: $rate, succeedcount: $succeedcount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel2 &&
      other.uid == uid &&
      other.username == username &&
      other.password == password &&
      other.email == email &&
      other.bio == bio &&
      other.profileUrl == profileUrl &&
      other.rate == rate &&
      other.succeedcount == succeedcount;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      username.hashCode ^
      password.hashCode ^
      email.hashCode ^
      bio.hashCode ^
      profileUrl.hashCode ^
      rate.hashCode ^
      succeedcount.hashCode;
  }
 }
