// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  uid: json['uid'] as String,
  displayName: json['displayName'] as String,
  avatarUrl: json['avatarUrl'] as String,
  friendInviteToken: json['friendInviteToken'] as String,
  friends:
      (json['friends'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  fcmToken: json['fcmToken'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'friendInviteToken': instance.friendInviteToken,
      'friends': instance.friends,
      'fcmToken': instance.fcmToken,
      'createdAt': instance.createdAt.toIso8601String(),
    };
