// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bluesky_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$BlueskyProfile {
  String get did => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String get avatar => throw _privateConstructorUsedError;
  String get handle => throw _privateConstructorUsedError;

  /// Create a copy of BlueskyProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BlueskyProfileCopyWith<BlueskyProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlueskyProfileCopyWith<$Res> {
  factory $BlueskyProfileCopyWith(
    BlueskyProfile value,
    $Res Function(BlueskyProfile) then,
  ) = _$BlueskyProfileCopyWithImpl<$Res, BlueskyProfile>;
  @useResult
  $Res call({String did, String displayName, String avatar, String handle});
}

/// @nodoc
class _$BlueskyProfileCopyWithImpl<$Res, $Val extends BlueskyProfile>
    implements $BlueskyProfileCopyWith<$Res> {
  _$BlueskyProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BlueskyProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? did = null,
    Object? displayName = null,
    Object? avatar = null,
    Object? handle = null,
  }) {
    return _then(
      _value.copyWith(
            did:
                null == did
                    ? _value.did
                    : did // ignore: cast_nullable_to_non_nullable
                        as String,
            displayName:
                null == displayName
                    ? _value.displayName
                    : displayName // ignore: cast_nullable_to_non_nullable
                        as String,
            avatar:
                null == avatar
                    ? _value.avatar
                    : avatar // ignore: cast_nullable_to_non_nullable
                        as String,
            handle:
                null == handle
                    ? _value.handle
                    : handle // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BlueskyProfileImplCopyWith<$Res>
    implements $BlueskyProfileCopyWith<$Res> {
  factory _$$BlueskyProfileImplCopyWith(
    _$BlueskyProfileImpl value,
    $Res Function(_$BlueskyProfileImpl) then,
  ) = __$$BlueskyProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String did, String displayName, String avatar, String handle});
}

/// @nodoc
class __$$BlueskyProfileImplCopyWithImpl<$Res>
    extends _$BlueskyProfileCopyWithImpl<$Res, _$BlueskyProfileImpl>
    implements _$$BlueskyProfileImplCopyWith<$Res> {
  __$$BlueskyProfileImplCopyWithImpl(
    _$BlueskyProfileImpl _value,
    $Res Function(_$BlueskyProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BlueskyProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? did = null,
    Object? displayName = null,
    Object? avatar = null,
    Object? handle = null,
  }) {
    return _then(
      _$BlueskyProfileImpl(
        did:
            null == did
                ? _value.did
                : did // ignore: cast_nullable_to_non_nullable
                    as String,
        displayName:
            null == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                    as String,
        avatar:
            null == avatar
                ? _value.avatar
                : avatar // ignore: cast_nullable_to_non_nullable
                    as String,
        handle:
            null == handle
                ? _value.handle
                : handle // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$BlueskyProfileImpl implements _BlueskyProfile {
  const _$BlueskyProfileImpl({
    required this.did,
    required this.displayName,
    required this.avatar,
    required this.handle,
  });

  @override
  final String did;
  @override
  final String displayName;
  @override
  final String avatar;
  @override
  final String handle;

  @override
  String toString() {
    return 'BlueskyProfile(did: $did, displayName: $displayName, avatar: $avatar, handle: $handle)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BlueskyProfileImpl &&
            (identical(other.did, did) || other.did == did) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.handle, handle) || other.handle == handle));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, did, displayName, avatar, handle);

  /// Create a copy of BlueskyProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BlueskyProfileImplCopyWith<_$BlueskyProfileImpl> get copyWith =>
      __$$BlueskyProfileImplCopyWithImpl<_$BlueskyProfileImpl>(
        this,
        _$identity,
      );
}

abstract class _BlueskyProfile implements BlueskyProfile {
  const factory _BlueskyProfile({
    required final String did,
    required final String displayName,
    required final String avatar,
    required final String handle,
  }) = _$BlueskyProfileImpl;

  @override
  String get did;
  @override
  String get displayName;
  @override
  String get avatar;
  @override
  String get handle;

  /// Create a copy of BlueskyProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BlueskyProfileImplCopyWith<_$BlueskyProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
