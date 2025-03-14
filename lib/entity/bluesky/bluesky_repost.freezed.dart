// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bluesky_repost.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$BlueskyRepost {
  AtUri get postUri => throw _privateConstructorUsedError;
  String get did => throw _privateConstructorUsedError;

  /// Create a copy of BlueskyRepost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BlueskyRepostCopyWith<BlueskyRepost> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlueskyRepostCopyWith<$Res> {
  factory $BlueskyRepostCopyWith(
    BlueskyRepost value,
    $Res Function(BlueskyRepost) then,
  ) = _$BlueskyRepostCopyWithImpl<$Res, BlueskyRepost>;
  @useResult
  $Res call({AtUri postUri, String did});
}

/// @nodoc
class _$BlueskyRepostCopyWithImpl<$Res, $Val extends BlueskyRepost>
    implements $BlueskyRepostCopyWith<$Res> {
  _$BlueskyRepostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BlueskyRepost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? postUri = null, Object? did = null}) {
    return _then(
      _value.copyWith(
            postUri:
                null == postUri
                    ? _value.postUri
                    : postUri // ignore: cast_nullable_to_non_nullable
                        as AtUri,
            did:
                null == did
                    ? _value.did
                    : did // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BlueskyRepostImplCopyWith<$Res>
    implements $BlueskyRepostCopyWith<$Res> {
  factory _$$BlueskyRepostImplCopyWith(
    _$BlueskyRepostImpl value,
    $Res Function(_$BlueskyRepostImpl) then,
  ) = __$$BlueskyRepostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AtUri postUri, String did});
}

/// @nodoc
class __$$BlueskyRepostImplCopyWithImpl<$Res>
    extends _$BlueskyRepostCopyWithImpl<$Res, _$BlueskyRepostImpl>
    implements _$$BlueskyRepostImplCopyWith<$Res> {
  __$$BlueskyRepostImplCopyWithImpl(
    _$BlueskyRepostImpl _value,
    $Res Function(_$BlueskyRepostImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BlueskyRepost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? postUri = null, Object? did = null}) {
    return _then(
      _$BlueskyRepostImpl(
        postUri:
            null == postUri
                ? _value.postUri
                : postUri // ignore: cast_nullable_to_non_nullable
                    as AtUri,
        did:
            null == did
                ? _value.did
                : did // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$BlueskyRepostImpl implements _BlueskyRepost {
  const _$BlueskyRepostImpl({required this.postUri, required this.did});

  @override
  final AtUri postUri;
  @override
  final String did;

  @override
  String toString() {
    return 'BlueskyRepost(postUri: $postUri, did: $did)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BlueskyRepostImpl &&
            (identical(other.postUri, postUri) || other.postUri == postUri) &&
            (identical(other.did, did) || other.did == did));
  }

  @override
  int get hashCode => Object.hash(runtimeType, postUri, did);

  /// Create a copy of BlueskyRepost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BlueskyRepostImplCopyWith<_$BlueskyRepostImpl> get copyWith =>
      __$$BlueskyRepostImplCopyWithImpl<_$BlueskyRepostImpl>(this, _$identity);
}

abstract class _BlueskyRepost implements BlueskyRepost {
  const factory _BlueskyRepost({
    required final AtUri postUri,
    required final String did,
  }) = _$BlueskyRepostImpl;

  @override
  AtUri get postUri;
  @override
  String get did;

  /// Create a copy of BlueskyRepost
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BlueskyRepostImplCopyWith<_$BlueskyRepostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
