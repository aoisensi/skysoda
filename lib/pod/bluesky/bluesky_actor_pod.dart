import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skysoda/entity/bluesky/bluesky_actor.dart';
import 'package:skysoda/pod/atproto/atproto_session_pod.dart';
import 'package:skysoda/pod/bluesky/bluesky_session_pod.dart';

final podBlueskyActor = AsyncNotifierProvider.autoDispose
    .family<BlueskyActorNotifier, BlueskyActor, String>(
      BlueskyActorNotifier.new,
      dependencies: [podAtprotoDid, podAtproto, podBluesky],
    );

class BlueskyActorNotifier
    extends AutoDisposeFamilyAsyncNotifier<BlueskyActor, String> {
  @override
  FutureOr<BlueskyActor> build(arg) async {
    final value = ref.watch(podBlueskyActorCache(arg));
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
    final bluesky = await ref.watch(podBluesky.future);
    final data = await bluesky.actor.getProfile(actor: arg);
    final cache = ref.watch(podBlueskyActorCache(arg).notifier);
    final profile = BlueskyActor.fromActorProfile(data.data);
    cache.state = AsyncData(profile);
    return profile;
  }
}

final podBlueskyActorCache =
    StateProviderFamily<AsyncValue<BlueskyActor>?, String>((ref, _) => null);
