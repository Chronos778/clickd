// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PhotoModel _$PhotoModelFromJson(Map<String, dynamic> json) => _PhotoModel(
  id: json['id'] as String? ?? '',
  groupId: json['groupId'] as String,
  uploadedBy: json['uploadedBy'] as String,
  thumbUrl: json['thumbUrl'] as String?,
  fullUrl: json['fullUrl'] as String?,
  storageThumbPath: json['storageThumbPath'] as String?,
  storageFullPath: json['storageFullPath'] as String?,
  imageHash: json['imageHash'] as String,
  width: (json['width'] as num).toInt(),
  height: (json['height'] as num).toInt(),
  memberCount: (json['memberCount'] as num).toInt(),
  downloadedBy:
      (json['downloadedBy'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  createdAt: DateTime.parse(json['createdAt'] as String),
  deletedFromStorage: json['deletedFromStorage'] as bool? ?? false,
  signedUrlExpiry: DateTime.parse(json['signedUrlExpiry'] as String),
);

Map<String, dynamic> _$PhotoModelToJson(_PhotoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'groupId': instance.groupId,
      'uploadedBy': instance.uploadedBy,
      'thumbUrl': instance.thumbUrl,
      'fullUrl': instance.fullUrl,
      'storageThumbPath': instance.storageThumbPath,
      'storageFullPath': instance.storageFullPath,
      'imageHash': instance.imageHash,
      'width': instance.width,
      'height': instance.height,
      'memberCount': instance.memberCount,
      'downloadedBy': instance.downloadedBy,
      'createdAt': instance.createdAt.toIso8601String(),
      'deletedFromStorage': instance.deletedFromStorage,
      'signedUrlExpiry': instance.signedUrlExpiry.toIso8601String(),
    };
