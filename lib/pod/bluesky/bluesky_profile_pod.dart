import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skysoda/entity/bluesky/bluesky_profile.dart';
import 'package:skysoda/pod/bluesky/bluesky_session_pod.dart';

final podBlueskyProfile = AsyncNotifierProvider.autoDispose
    .family<BlueskyProfileNotifier, BlueskyProfile, (String, String)>(
      BlueskyProfileNotifier.new,
    );

class BlueskyProfileNotifier
    extends AutoDisposeFamilyAsyncNotifier<BlueskyProfile, (String, String)> {
  @override
  FutureOr<BlueskyProfile> build(arg) async {
    final value = ref.watch(podBlueskyProfileCache(arg.$2));
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
    final bluesky = await ref.watch(podBluesky(arg.$1).future);
    final data = await bluesky.actor.getProfile(actor: arg.$2);
    final cache = ref.watch(podBlueskyProfileCache(arg.$2).notifier);
    final profile = BlueskyProfile.fromActorProfile(data.data);
    cache.state = AsyncData(profile);
    return profile;
  }
}

final podBlueskyProfileCache =
    StateProviderFamily<AsyncValue<BlueskyProfile>?, String>((ref, _) => null);
