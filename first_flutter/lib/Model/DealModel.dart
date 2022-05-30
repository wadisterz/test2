// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DealModel {
  final String deaiid;
  final String heading;
  final String detail;
  final String postbyid;
  final String takebyid;
  final String postby;
  final String takeby;
  final bool succeed;
  DealModel({
    required this.deaiid,
    required this.heading,
    required this.detail,
    required this.postbyid,
    required this.takebyid,
    required this.postby,
    required this.takeby,
    required this.succeed,
  });
  


  DealModel copyWith({
    String? deaiid,
    String? heading,
    String? detail,
    String? postbyid,
    String? takebyid,
    String? postby,
    String? takeby,
    bool? succeed,
  }) {
    return DealModel(
      deaiid: deaiid ?? this.deaiid,
      heading: heading ?? this.heading,
      detail: detail ?? this.detail,
      postbyid: postbyid ?? this.postbyid,
      takebyid: takebyid ?? this.takebyid,
      postby: postby ?? this.postby,
      takeby: takeby ?? this.takeby,
      succeed: succeed ?? this.succeed,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'deaiid': deaiid,
      'heading': heading,
      'detail': detail,
      'postbyid': postbyid,
      'takebyid': takebyid,
      'postby': postby,
      'takeby': takeby,
      'succeed': succeed,
    };
  }

  factory DealModel.fromMap(Map<String, dynamic> map) {
    return DealModel(
      deaiid: map['deaiid'] as String,
      heading: map['heading'] as String,
      detail: map['detail'] as String,
      postbyid: map['postbyid'] as String,
      takebyid: map['takebyid'] as String,
      postby: map['postby'] as String,
      takeby: map['takeby'] as String,
      succeed: map['succeed'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory DealModel.fromJson(String source) => DealModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DealModel(deaiid: $deaiid, heading: $heading, detail: $detail, postbyid: $postbyid, takebyid: $takebyid, postby: $postby, takeby: $takeby, succeed: $succeed)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is DealModel &&
      other.deaiid == deaiid &&
      other.heading == heading &&
      other.detail == detail &&
      other.postbyid == postbyid &&
      other.takebyid == takebyid &&
      other.postby == postby &&
      other.takeby == takeby &&
      other.succeed == succeed;
  }

  @override
  int get hashCode {
    return deaiid.hashCode ^
      heading.hashCode ^
      detail.hashCode ^
      postbyid.hashCode ^
      takebyid.hashCode ^
      postby.hashCode ^
      takeby.hashCode ^
      succeed.hashCode;
  }
}
