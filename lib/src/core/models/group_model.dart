import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_model.freezed.dart';
part 'group_model.g.dart';

@freezed
abstract class GroupModel with _$GroupModel {
  const GroupModel._();
  const factory GroupModel({
    @Default('') String id,
    required String name,
    required String createdBy,
    @Default([]) List<String> members,
    String? coverPhotoUrl,
    required DateTime createdAt,
  }) = _GroupModel;

  factory GroupModel.fromJson(Map<String, dynamic> json) => _$GroupModelFromJson(json);
}
