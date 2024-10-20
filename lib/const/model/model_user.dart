import 'package:cloud_firestore/cloud_firestore.dart';
import '../enum/enums.dart';

class ModelUser {
  final String uid;
  final String nickname;
  final String email;
  final Timestamp dateCreate;
  final int birthYear;
  final int experienceMonth;
  final String phoneNumber;
  final EnumLoginType loginType;
  final int winPoint;
  final bool isShowTutorial;

  const ModelUser({
    required this.uid,
    required this.nickname,
    required this.email,
    required this.dateCreate,
    required this.experienceMonth,
    required this.birthYear,
    required this.phoneNumber,
    required this.loginType,
    this.winPoint = 0,
    this.isShowTutorial = true,
  });

  // fromJson
  factory ModelUser.fromJson(Map<String, dynamic> json) {
    return ModelUser(
      uid: json['uid'],
      nickname: json['nickname'],
      email: json['email'],
      dateCreate: json['dateCreate'],
      experienceMonth: json['experienceMonth'],
      birthYear: json['birthYear'],
      phoneNumber: json['phoneNumber'],
      loginType: EnumLoginType.values.firstWhere((e) => e.name == json['loginType']),
      winPoint: json['winPoint'] ?? 0,
      isShowTutorial: json['isShowTutorial'] ?? true,
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'nickname': nickname,
      'email': email,
      'dateCreate': dateCreate,
      'experienceMonth': experienceMonth,
      'birthYear': birthYear,
      'phoneNumber': phoneNumber,
      'loginType': loginType.name,
      'winPoint': winPoint,
      'isShowTutorial': isShowTutorial,
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
    bool? isShowTutorial,
  }) {
    return ModelUser(
      uid: uid ?? this.uid,
      nickname: nickname ?? this.nickname,
      email: email ?? this.email,
      dateCreate: dateCreate ?? this.dateCreate,
      experienceMonth: experienceMonth ?? this.experienceMonth,
      birthYear: birthYear ?? this.birthYear,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      loginType: loginType ?? this.loginType,
      winPoint: winPoint ?? this.winPoint,
      isShowTutorial: isShowTutorial ?? this.isShowTutorial,
    );
  }
}
