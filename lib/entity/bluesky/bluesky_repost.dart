import 'package:atproto/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bluesky_repost.freezed.dart';

@freezed
class BlueskyRepost with _$BlueskyRepost {
  const factory BlueskyRepost({required AtUri postUri, required String did}) =
      _BlueskyRepost;
}
