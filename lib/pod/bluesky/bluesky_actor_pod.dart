import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../entity/bluesky/bluesky_actor.dart';
import '../atproto/atproto_session_pod.dart';
import 'bluesky_session_pod.dart';

final blueskyActorPod = AsyncNotifierProvider.autoDispose
    .family<BlueskyActorNotifier, BlueskyActor, String>(
      BlueskyActorNotifier.new,
      dependencies: [atprotoDidPod, atprotoPod, blueskyPod],
    );

class BlueskyActorNotifier
    extends AutoDisposeFamilyAsyncNotifier<BlueskyActor, String> {
  @override
  FutureOr<BlueskyActor> build(arg) async {
    final value = ref.watch(blueskyActorCachePod(arg));
    if (value != null) {
      switch (value) {
        case AsyncLoading():
          return future;
        case AsyncError error:
          throw error;
        case AsyncData(:final value):
          return value;
      }
    }
    final bluesky = await ref.watch(blueskyPod.future);
    final data = await bluesky.actor.getProfile(actor: arg);
    final cache = ref.watch(blueskyActorCachePod(arg).notifier);
    final profile = BlueskyActor.fromActorProfile(data.data);
    cache.state = AsyncData(profile);
    return profile;
  }
}

final blueskyActorCachePod =
    StateProviderFamily<AsyncValue<BlueskyActor>?, String>((ref, _) => null);
