import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo_model.freezed.dart';
part 'photo_model.g.dart';

@freezed
abstract class PhotoModel with _$PhotoModel {
  const PhotoModel._();
  const factory PhotoModel({
    @Default('') String id,
    required String groupId,
    required String uploadedBy,
    String? thumbUrl,
    String? fullUrl,
    String? storageThumbPath,
    String? storageFullPath,
    required String imageHash,
    required int width,
    required int height,
    required int memberCount,
    @Default([]) List<String> downloadedBy,
    required DateTime createdAt,
    @Default(false) bool deletedFromStorage,
    required DateTime signedUrlExpiry,
  }) = _PhotoModel;

  factory PhotoModel.fromJson(Map<String, dynamic> json) => _$PhotoModelFromJson(json);
}
