import 'dart:async';

import 'package:atproto/core.dart' as $atp;
import 'package:bluesky/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skysoda/entity/bluesky/bluesky_post.dart';
import 'package:skysoda/entity/bluesky/bluesky_actor.dart';
import 'package:skysoda/pod/atproto/atproto_session_pod.dart';
import 'package:skysoda/pod/bluesky/bluesky_actor_pod.dart';
import 'package:skysoda/pod/bluesky/bluesky_session_pod.dart';

final blueskyPostPod = AsyncNotifierProvider.autoDispose
    .family<BlueskyPostNotifier, BlueskyPost, $atp.AtUri>(
      BlueskyPostNotifier.new,
      dependencies: [atprotoDidPod, atprotoPod, blueskyPod],
    );

class BlueskyPostNotifier
    extends AutoDisposeFamilyAsyncNotifier<BlueskyPost, $atp.AtUri> {
  @override
  FutureOr<BlueskyPost> build(AtUri arg) async {
    final value = ref.watch(blueskyPostCachePod(arg));
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
    final data = await bluesky.feed.getPosts(uris: [arg]);
    final cache = ref.watch(blueskyPostCachePod(arg).notifier);
    final post = BlueskyPost.fromPost(data.data.posts.first);
    cache.state = AsyncData(post);
    return post;
  }

  static Future<void> fetchAll(Ref ref, List<$atp.AtUri> uris) async {
    final bluesky = await ref.watch(blueskyPod.future);
    for (final uri in uris) {
      ref.watch(blueskyPostCachePod(uri).notifier).state = AsyncLoading();
    }
    try {
      final data = await bluesky.feed.getPosts(uris: uris);
      for (final data in data.data.posts) {
        final post = BlueskyPost.fromPost(data);
        final profile = BlueskyActor.fromActorBasic(data.author);
        ref.watch(blueskyPostCachePod(data.uri).notifier).state = AsyncData(
          post,
        );
        ref
            .watch(blueskyActorCachePod(data.author.did).notifier)
            .state = AsyncData(profile);
      }
    } catch (error, stackTrace) {
      for (final uri in uris) {
        ref.watch(blueskyPostCachePod(uri).notifier).state = AsyncError(
          error,
          stackTrace,
        );
      }
    }
  }
}

final blueskyPostCachePod =
    StateProvider.family<AsyncValue<BlueskyPost>?, AtUri>((ref, _) => null);
