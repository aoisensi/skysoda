import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skysoda/entity/bluesky/bluesky_profile.dart';
import 'package:skysoda/pod/bluesky/bluesky_session_pod.dart';

final podBlueskyProfile = AsyncNotifierProvider.autoDispose
    .family<BlueskyProfileNotifier, BlueskyProfile, String>(
      BlueskyProfileNotifier.new,
    );

class BlueskyProfileNotifier
    extends AutoDisposeFamilyAsyncNotifier<BlueskyProfile, String> {
  @override
  FutureOr<BlueskyProfile> build(arg) async {
    final value = ref.watch(podBlueskyProfileCache(arg));
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
    final cache = ref.watch(podBlueskyProfileCache(arg).notifier);
    final profile = BlueskyProfile.fromActorProfile(data.data);
    cache.state = AsyncData(profile);
    return profile;
  }
}

final podBlueskyProfileCache =
    StateProviderFamily<AsyncValue<BlueskyProfile>?, String>((ref, _) => null);
