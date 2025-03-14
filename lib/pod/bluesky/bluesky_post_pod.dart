import 'dart:async';

import 'package:atproto/core.dart' as $atp;
import 'package:bluesky/bluesky.dart' as $bsky;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../entity/bluesky/bluesky_post.dart';
import '../../entity/bluesky/bluesky_actor.dart';
import '../../entity/bluesky/bluesky_repost.dart';
import 'bluesky_actor_pod.dart';
import 'bluesky_repost_pod.dart';
import 'bluesky_session_pod.dart';
import 'bluesky_subscribe_pod.dart';

final blueskyPostPod = AsyncNotifierProvider.autoDispose
    .family<BlueskyPostNotifier, BlueskyPost, $atp.AtUri>(
      BlueskyPostNotifier.new,
      dependencies: [blueskyPod, blueskyActorPod],
    );

class BlueskyPostNotifier
    extends AutoDisposeFamilyAsyncNotifier<BlueskyPost, $atp.AtUri> {
  @override
  FutureOr<BlueskyPost> build($atp.AtUri arg) async {
    ref.listen(blueskySubscribePostDeletedPod, (_, commit) {
      if (commit == null) return;
      ref.invalidate(blueskyPostPod(commit.uri));
      ref.invalidate(blueskyPostCachePod(commit.uri));
    });
    final value = ref.watch(blueskyPostCachePod(arg));
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
    final bluesky = await ref.watch(blueskyPod.future);
    final data = await bluesky.feed.getPosts(uris: [arg]);
    final cache = ref.watch(blueskyPostCachePod(arg).notifier);
    final post = BlueskyPost.fromPost(data.data.posts.first);
    ref.watch(blueskyActorPod(post.did));
    cache.state = AsyncData(post);
    return post;
  }

  static void storeFeedView(Ref ref, $bsky.FeedView v) {
    final cache = ref.watch(blueskyPostCachePod(v.post.uri).notifier);
    final post = BlueskyPost.fromPost(v.post);
    cache.state = AsyncData(post);
    switch (v.reason?.data) {
      case $bsky.ReasonRepost reason:
        final repost = BlueskyRepost(postUri: v.post.uri, did: reason.by.did);
        final cache = ref.watch(
          blueskyRepostCachePod((repost.postUri, repost.did)).notifier,
        );
        cache.state = AsyncData(repost);
    }
  }

  static Future<void> fetchMultiple(Ref ref, List<$atp.AtUri> uris) async {
    final bluesky = await ref.watch(blueskyPod.future);
    for (final uri in uris) {
      ref.watch(blueskyPostCachePod(uri).notifier).state = const AsyncLoading();
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
    StateProvider.family<AsyncValue<BlueskyPost>?, $atp.AtUri>(
      (ref, _) => null,
    );
