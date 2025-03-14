import 'dart:async';

import 'package:atproto/core.dart' as $atp;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../entity/bluesky/bluesky_repost.dart';
import 'bluesky_actor_pod.dart';

class BlueskyRepostNotifier
    extends
        AutoDisposeFamilyAsyncNotifier<BlueskyRepost, ($atp.AtUri, String)> {
  @override
  FutureOr<BlueskyRepost> build(($atp.AtUri, String) arg) async {
    final value = ref.watch(blueskyRepostCachePod(arg));
    if (value != null) {
      switch (value) {
        case AsyncLoading():
          return future;
        case AsyncError(:final error):
          throw error;
        case AsyncData(:final value):
          ref.watch(blueskyActorPod(value.did));
          return value;
      }
    }
    final cache = ref.watch(blueskyRepostCachePod(arg).notifier);
    final repost = BlueskyRepost(postUri: arg.$1, did: arg.$2);
    cache.state = AsyncData(repost);
    return repost;
  }
}

final blueskyRepostCachePod =
    StateProvider.family<AsyncValue<BlueskyRepost>?, ($atp.AtUri, String)>(
      (ref, arg) => null,
    );
