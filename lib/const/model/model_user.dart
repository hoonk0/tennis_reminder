import 'package:cloud_firestore/cloud_firestore.dart';
import '../enum/enums.dart';

class ModelUser {
  final String uid;
  final String nickname;
  final String email;
  final String phoneNumber;
  final EnumLoginType loginType;

  const ModelUser({
    required this.uid,
    required this.nickname,
    required this.email,
    required this.phoneNumber,
    required this.loginType,
  });

  // fromJson
  factory ModelUser.fromJson(Map<String, dynamic> json) {
    return ModelUser(
      uid: json['uid'],
      nickname: json['nickname'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      loginType: EnumLoginType.values.firstWhere((e) => e.name == json['loginType']),
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'nickname': nickname,
      'email': email,
      'phoneNumber': phoneNumber,
      'loginType': loginType.name,
    };
  }

  // copyWith
  ModelUser copyWith({
    String? uid,
    String? nickname,
    String? email,
    Timestamp? dateCreate,
    int? experienceMonth,
    int? birthYear,
    String? phoneNumber,
    EnumLoginType? loginType,
    int? winPoint,
  }) {
    return ModelUser(
      uid: uid ?? this.uid,
      nickname: nickname ?? this.nickname,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      loginType: loginType ?? this.loginType,
    );
  }
}
