import 'package:bluesky/bluesky.dart' as $bsky;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bluesky_profile.freezed.dart';

@freezed
abstract class BlueskyProfile with _$BlueskyProfile {
  const factory BlueskyProfile({
    required String did,
    required String displayName,
    required String avatar,
    required String handle,
  }) = _BlueskyProfile;

  factory BlueskyProfile.fromActorProfile($bsky.ActorProfile v) {
    return BlueskyProfile(
      did: v.did,
      displayName: v.displayName!,
      avatar: v.avatar!,
      handle: v.handle,
    );
  }

  factory BlueskyProfile.fromActorBasic($bsky.ActorBasic v) {
    return BlueskyProfile(
      did: v.did,
      displayName: v.displayName!,
      avatar: v.avatar!,
      handle: v.handle,
    );
  }
}
