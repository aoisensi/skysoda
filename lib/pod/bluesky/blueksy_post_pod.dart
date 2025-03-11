import 'dart:async';

import 'package:atproto/core.dart' as $atp;
import 'package:bluesky/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skysoda/entity/bluesky/bluesky_post.dart';
import 'package:skysoda/pod/bluesky/bluesky_session_pod.dart';

final podBlueskyPost = AsyncNotifierProvider.autoDispose
    .family<BlueskyPostNotifier, BlueskyPost, $atp.AtUri>(
      BlueskyPostNotifier.new,
    );

class BlueskyPostNotifier
    extends AutoDisposeFamilyAsyncNotifier<BlueskyPost, $atp.AtUri> {
  @override
  FutureOr<BlueskyPost> build(AtUri arg) async {
    final value = ref.watch(podBlueskyPostCache(arg));
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
    final data = await bluesky.feed.getPosts(uris: [arg]);
    final cache = ref.watch(podBlueskyPostCache(arg).notifier);
    final post = BlueskyPost.fromPost(data.data.posts.first);
    cache.state = AsyncData(post);
    return post;
  }
}

final podBlueskyPostCache =
    StateProvider.family<AsyncValue<BlueskyPost>?, AtUri>((ref, _) => null);
