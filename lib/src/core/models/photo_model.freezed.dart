// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'photo_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PhotoModel {

 String get id; String get groupId; String get uploadedBy; String? get thumbUrl; String? get fullUrl; String? get storageThumbPath; String? get storageFullPath; String get imageHash; int get width; int get height; int get memberCount; List<String> get downloadedBy; DateTime get createdAt; bool get deletedFromStorage; DateTime get signedUrlExpiry;
/// Create a copy of PhotoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhotoModelCopyWith<PhotoModel> get copyWith => _$PhotoModelCopyWithImpl<PhotoModel>(this as PhotoModel, _$identity);

  /// Serializes this PhotoModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhotoModel&&(identical(other.id, id) || other.id == id)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.uploadedBy, uploadedBy) || other.uploadedBy == uploadedBy)&&(identical(other.thumbUrl, thumbUrl) || other.thumbUrl == thumbUrl)&&(identical(other.fullUrl, fullUrl) || other.fullUrl == fullUrl)&&(identical(other.storageThumbPath, storageThumbPath) || other.storageThumbPath == storageThumbPath)&&(identical(other.storageFullPath, storageFullPath) || other.storageFullPath == storageFullPath)&&(identical(other.imageHash, imageHash) || other.imageHash == imageHash)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&const DeepCollectionEquality().equals(other.downloadedBy, downloadedBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.deletedFromStorage, deletedFromStorage) || other.deletedFromStorage == deletedFromStorage)&&(identical(other.signedUrlExpiry, signedUrlExpiry) || other.signedUrlExpiry == signedUrlExpiry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,groupId,uploadedBy,thumbUrl,fullUrl,storageThumbPath,storageFullPath,imageHash,width,height,memberCount,const DeepCollectionEquality().hash(downloadedBy),createdAt,deletedFromStorage,signedUrlExpiry);

@override
String toString() {
  return 'PhotoModel(id: $id, groupId: $groupId, uploadedBy: $uploadedBy, thumbUrl: $thumbUrl, fullUrl: $fullUrl, storageThumbPath: $storageThumbPath, storageFullPath: $storageFullPath, imageHash: $imageHash, width: $width, height: $height, memberCount: $memberCount, downloadedBy: $downloadedBy, createdAt: $createdAt, deletedFromStorage: $deletedFromStorage, signedUrlExpiry: $signedUrlExpiry)';
}


}

/// @nodoc
abstract mixin class $PhotoModelCopyWith<$Res>  {
  factory $PhotoModelCopyWith(PhotoModel value, $Res Function(PhotoModel) _then) = _$PhotoModelCopyWithImpl;
@useResult
$Res call({
 String id, String groupId, String uploadedBy, String? thumbUrl, String? fullUrl, String? storageThumbPath, String? storageFullPath, String imageHash, int width, int height, int memberCount, List<String> downloadedBy, DateTime createdAt, bool deletedFromStorage, DateTime signedUrlExpiry
});




}
/// @nodoc
class _$PhotoModelCopyWithImpl<$Res>
    implements $PhotoModelCopyWith<$Res> {
  _$PhotoModelCopyWithImpl(this._self, this._then);

  final PhotoModel _self;
  final $Res Function(PhotoModel) _then;

/// Create a copy of PhotoModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? groupId = null,Object? uploadedBy = null,Object? thumbUrl = freezed,Object? fullUrl = freezed,Object? storageThumbPath = freezed,Object? storageFullPath = freezed,Object? imageHash = null,Object? width = null,Object? height = null,Object? memberCount = null,Object? downloadedBy = null,Object? createdAt = null,Object? deletedFromStorage = null,Object? signedUrlExpiry = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,uploadedBy: null == uploadedBy ? _self.uploadedBy : uploadedBy // ignore: cast_nullable_to_non_nullable
as String,thumbUrl: freezed == thumbUrl ? _self.thumbUrl : thumbUrl // ignore: cast_nullable_to_non_nullable
as String?,fullUrl: freezed == fullUrl ? _self.fullUrl : fullUrl // ignore: cast_nullable_to_non_nullable
as String?,storageThumbPath: freezed == storageThumbPath ? _self.storageThumbPath : storageThumbPath // ignore: cast_nullable_to_non_nullable
as String?,storageFullPath: freezed == storageFullPath ? _self.storageFullPath : storageFullPath // ignore: cast_nullable_to_non_nullable
as String?,imageHash: null == imageHash ? _self.imageHash : imageHash // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,downloadedBy: null == downloadedBy ? _self.downloadedBy : downloadedBy // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,deletedFromStorage: null == deletedFromStorage ? _self.deletedFromStorage : deletedFromStorage // ignore: cast_nullable_to_non_nullable
as bool,signedUrlExpiry: null == signedUrlExpiry ? _self.signedUrlExpiry : signedUrlExpiry // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [PhotoModel].
extension PhotoModelPatterns on PhotoModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhotoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhotoModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhotoModel value)  $default,){
final _that = this;
switch (_that) {
case _PhotoModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhotoModel value)?  $default,){
final _that = this;
switch (_that) {
case _PhotoModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String groupId,  String uploadedBy,  String? thumbUrl,  String? fullUrl,  String? storageThumbPath,  String? storageFullPath,  String imageHash,  int width,  int height,  int memberCount,  List<String> downloadedBy,  DateTime createdAt,  bool deletedFromStorage,  DateTime signedUrlExpiry)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhotoModel() when $default != null:
return $default(_that.id,_that.groupId,_that.uploadedBy,_that.thumbUrl,_that.fullUrl,_that.storageThumbPath,_that.storageFullPath,_that.imageHash,_that.width,_that.height,_that.memberCount,_that.downloadedBy,_that.createdAt,_that.deletedFromStorage,_that.signedUrlExpiry);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String groupId,  String uploadedBy,  String? thumbUrl,  String? fullUrl,  String? storageThumbPath,  String? storageFullPath,  String imageHash,  int width,  int height,  int memberCount,  List<String> downloadedBy,  DateTime createdAt,  bool deletedFromStorage,  DateTime signedUrlExpiry)  $default,) {final _that = this;
switch (_that) {
case _PhotoModel():
return $default(_that.id,_that.groupId,_that.uploadedBy,_that.thumbUrl,_that.fullUrl,_that.storageThumbPath,_that.storageFullPath,_that.imageHash,_that.width,_that.height,_that.memberCount,_that.downloadedBy,_that.createdAt,_that.deletedFromStorage,_that.signedUrlExpiry);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String groupId,  String uploadedBy,  String? thumbUrl,  String? fullUrl,  String? storageThumbPath,  String? storageFullPath,  String imageHash,  int width,  int height,  int memberCount,  List<String> downloadedBy,  DateTime createdAt,  bool deletedFromStorage,  DateTime signedUrlExpiry)?  $default,) {final _that = this;
switch (_that) {
case _PhotoModel() when $default != null:
return $default(_that.id,_that.groupId,_that.uploadedBy,_that.thumbUrl,_that.fullUrl,_that.storageThumbPath,_that.storageFullPath,_that.imageHash,_that.width,_that.height,_that.memberCount,_that.downloadedBy,_that.createdAt,_that.deletedFromStorage,_that.signedUrlExpiry);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhotoModel extends PhotoModel {
  const _PhotoModel({this.id = '', required this.groupId, required this.uploadedBy, this.thumbUrl, this.fullUrl, this.storageThumbPath, this.storageFullPath, required this.imageHash, required this.width, required this.height, required this.memberCount, final  List<String> downloadedBy = const [], required this.createdAt, this.deletedFromStorage = false, required this.signedUrlExpiry}): _downloadedBy = downloadedBy,super._();
  factory _PhotoModel.fromJson(Map<String, dynamic> json) => _$PhotoModelFromJson(json);

@override@JsonKey() final  String id;
@override final  String groupId;
@override final  String uploadedBy;
@override final  String? thumbUrl;
@override final  String? fullUrl;
@override final  String? storageThumbPath;
@override final  String? storageFullPath;
@override final  String imageHash;
@override final  int width;
@override final  int height;
@override final  int memberCount;
 final  List<String> _downloadedBy;
@override@JsonKey() List<String> get downloadedBy {
  if (_downloadedBy is EqualUnmodifiableListView) return _downloadedBy;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_downloadedBy);
}

@override final  DateTime createdAt;
@override@JsonKey() final  bool deletedFromStorage;
@override final  DateTime signedUrlExpiry;

/// Create a copy of PhotoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhotoModelCopyWith<_PhotoModel> get copyWith => __$PhotoModelCopyWithImpl<_PhotoModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhotoModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhotoModel&&(identical(other.id, id) || other.id == id)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.uploadedBy, uploadedBy) || other.uploadedBy == uploadedBy)&&(identical(other.thumbUrl, thumbUrl) || other.thumbUrl == thumbUrl)&&(identical(other.fullUrl, fullUrl) || other.fullUrl == fullUrl)&&(identical(other.storageThumbPath, storageThumbPath) || other.storageThumbPath == storageThumbPath)&&(identical(other.storageFullPath, storageFullPath) || other.storageFullPath == storageFullPath)&&(identical(other.imageHash, imageHash) || other.imageHash == imageHash)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&const DeepCollectionEquality().equals(other._downloadedBy, _downloadedBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.deletedFromStorage, deletedFromStorage) || other.deletedFromStorage == deletedFromStorage)&&(identical(other.signedUrlExpiry, signedUrlExpiry) || other.signedUrlExpiry == signedUrlExpiry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,groupId,uploadedBy,thumbUrl,fullUrl,storageThumbPath,storageFullPath,imageHash,width,height,memberCount,const DeepCollectionEquality().hash(_downloadedBy),createdAt,deletedFromStorage,signedUrlExpiry);

@override
String toString() {
  return 'PhotoModel(id: $id, groupId: $groupId, uploadedBy: $uploadedBy, thumbUrl: $thumbUrl, fullUrl: $fullUrl, storageThumbPath: $storageThumbPath, storageFullPath: $storageFullPath, imageHash: $imageHash, width: $width, height: $height, memberCount: $memberCount, downloadedBy: $downloadedBy, createdAt: $createdAt, deletedFromStorage: $deletedFromStorage, signedUrlExpiry: $signedUrlExpiry)';
}


}

/// @nodoc
abstract mixin class _$PhotoModelCopyWith<$Res> implements $PhotoModelCopyWith<$Res> {
  factory _$PhotoModelCopyWith(_PhotoModel value, $Res Function(_PhotoModel) _then) = __$PhotoModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String groupId, String uploadedBy, String? thumbUrl, String? fullUrl, String? storageThumbPath, String? storageFullPath, String imageHash, int width, int height, int memberCount, List<String> downloadedBy, DateTime createdAt, bool deletedFromStorage, DateTime signedUrlExpiry
});




}
/// @nodoc
class __$PhotoModelCopyWithImpl<$Res>
    implements _$PhotoModelCopyWith<$Res> {
  __$PhotoModelCopyWithImpl(this._self, this._then);

  final _PhotoModel _self;
  final $Res Function(_PhotoModel) _then;

/// Create a copy of PhotoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? groupId = null,Object? uploadedBy = null,Object? thumbUrl = freezed,Object? fullUrl = freezed,Object? storageThumbPath = freezed,Object? storageFullPath = freezed,Object? imageHash = null,Object? width = null,Object? height = null,Object? memberCount = null,Object? downloadedBy = null,Object? createdAt = null,Object? deletedFromStorage = null,Object? signedUrlExpiry = null,}) {
  return _then(_PhotoModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,uploadedBy: null == uploadedBy ? _self.uploadedBy : uploadedBy // ignore: cast_nullable_to_non_nullable
as String,thumbUrl: freezed == thumbUrl ? _self.thumbUrl : thumbUrl // ignore: cast_nullable_to_non_nullable
as String?,fullUrl: freezed == fullUrl ? _self.fullUrl : fullUrl // ignore: cast_nullable_to_non_nullable
as String?,storageThumbPath: freezed == storageThumbPath ? _self.storageThumbPath : storageThumbPath // ignore: cast_nullable_to_non_nullable
as String?,storageFullPath: freezed == storageFullPath ? _self.storageFullPath : storageFullPath // ignore: cast_nullable_to_non_nullable
as String?,imageHash: null == imageHash ? _self.imageHash : imageHash // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,downloadedBy: null == downloadedBy ? _self._downloadedBy : downloadedBy // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,deletedFromStorage: null == deletedFromStorage ? _self.deletedFromStorage : deletedFromStorage // ignore: cast_nullable_to_non_nullable
as bool,signedUrlExpiry: null == signedUrlExpiry ? _self.signedUrlExpiry : signedUrlExpiry // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
