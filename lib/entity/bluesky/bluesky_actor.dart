import 'package:bluesky/bluesky.dart' as $bsky;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bluesky_actor.freezed.dart';

@freezed
abstract class BlueskyActor with _$BlueskyActor {
  const factory BlueskyActor({
    required String did,
    required String displayName,
    required String? avatar,
    required String handle,
  }) = _BlueskyActor;

  factory BlueskyActor.fromActor($bsky.Actor v) {
    return BlueskyActor(
      did: v.did,
      displayName: v.displayName!,
      avatar: v.avatar,
      handle: v.handle,
    );
  }

  factory BlueskyActor.fromActorProfile($bsky.ActorProfile v) {
    return BlueskyActor(
      did: v.did,
      displayName: v.displayName!,
      avatar: v.avatar!,
      handle: v.handle,
    );
  }

  factory BlueskyActor.fromActorBasic($bsky.ActorBasic v) {
    return BlueskyActor(
      did: v.did,
      displayName: v.displayName!,
      avatar: v.avatar!,
      handle: v.handle,
    );
  }
}
