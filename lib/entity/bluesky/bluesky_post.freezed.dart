// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bluesky_post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$BlueskyPost {
  String get did => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  AtUri get uri => throw _privateConstructorUsedError;

  /// Create a copy of BlueskyPost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BlueskyPostCopyWith<BlueskyPost> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlueskyPostCopyWith<$Res> {
  factory $BlueskyPostCopyWith(
    BlueskyPost value,
    $Res Function(BlueskyPost) then,
  ) = _$BlueskyPostCopyWithImpl<$Res, BlueskyPost>;
  @useResult
  $Res call({String did, String text, AtUri uri});
}

/// @nodoc
class _$BlueskyPostCopyWithImpl<$Res, $Val extends BlueskyPost>
    implements $BlueskyPostCopyWith<$Res> {
  _$BlueskyPostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BlueskyPost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? did = null, Object? text = null, Object? uri = null}) {
    return _then(
      _value.copyWith(
            did:
                null == did
                    ? _value.did
                    : did // ignore: cast_nullable_to_non_nullable
                        as String,
            text:
                null == text
                    ? _value.text
                    : text // ignore: cast_nullable_to_non_nullable
                        as String,
            uri:
                null == uri
                    ? _value.uri
                    : uri // ignore: cast_nullable_to_non_nullable
                        as AtUri,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BlueskyPostImplCopyWith<$Res>
    implements $BlueskyPostCopyWith<$Res> {
  factory _$$BlueskyPostImplCopyWith(
    _$BlueskyPostImpl value,
    $Res Function(_$BlueskyPostImpl) then,
  ) = __$$BlueskyPostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String did, String text, AtUri uri});
}

/// @nodoc
class __$$BlueskyPostImplCopyWithImpl<$Res>
    extends _$BlueskyPostCopyWithImpl<$Res, _$BlueskyPostImpl>
    implements _$$BlueskyPostImplCopyWith<$Res> {
  __$$BlueskyPostImplCopyWithImpl(
    _$BlueskyPostImpl _value,
    $Res Function(_$BlueskyPostImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BlueskyPost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? did = null, Object? text = null, Object? uri = null}) {
    return _then(
      _$BlueskyPostImpl(
        did:
            null == did
                ? _value.did
                : did // ignore: cast_nullable_to_non_nullable
                    as String,
        text:
            null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                    as String,
        uri:
            null == uri
                ? _value.uri
                : uri // ignore: cast_nullable_to_non_nullable
                    as AtUri,
      ),
    );
  }
}

/// @nodoc

class _$BlueskyPostImpl implements _BlueskyPost {
  const _$BlueskyPostImpl({
    required this.did,
    required this.text,
    required this.uri,
  });

  @override
  final String did;
  @override
  final String text;
  @override
  final AtUri uri;

  @override
  String toString() {
    return 'BlueskyPost(did: $did, text: $text, uri: $uri)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BlueskyPostImpl &&
            (identical(other.did, did) || other.did == did) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.uri, uri) || other.uri == uri));
  }

  @override
  int get hashCode => Object.hash(runtimeType, did, text, uri);

  /// Create a copy of BlueskyPost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BlueskyPostImplCopyWith<_$BlueskyPostImpl> get copyWith =>
      __$$BlueskyPostImplCopyWithImpl<_$BlueskyPostImpl>(this, _$identity);
}

abstract class _BlueskyPost implements BlueskyPost {
  const factory _BlueskyPost({
    required final String did,
    required final String text,
    required final AtUri uri,
  }) = _$BlueskyPostImpl;

  @override
  String get did;
  @override
  String get text;
  @override
  AtUri get uri;

  /// Create a copy of BlueskyPost
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BlueskyPostImplCopyWith<_$BlueskyPostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
