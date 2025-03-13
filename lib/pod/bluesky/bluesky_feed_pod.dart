import 'dart:async';

import 'package:atproto/core.dart' as $atp;
import 'package:bluesky/bluesky.dart' as $bsky;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../entity/bluesky/bluesky_post.dart';
import '../../entity/bluesky/bluesky_actor.dart';
import '../atproto/atproto_session_pod.dart';
import 'bluesky_follow_pod.dart';
import 'bluesky_post_pod.dart';
import 'bluesky_actor_pod.dart';
import 'bluesky_session_pod.dart';
import 'bluesky_subscribe_pod.dart';

final blueskyTimelinePod =
    AsyncNotifierProvider<BlueskyTimelineNotifier, List<$atp.AtUri>>(
      BlueskyTimelineNotifier.new,
      dependencies: [
        atprotoDidPod,
        atprotoPod,
        blueskyPod,
        blueskySelfAndAllFollowsPod,
      ],
    );

final blueskyTimelineKeepAlivePod = Provider((ref) {
  for (final uri in ref.watch(blueskyTimelinePod).valueOrNull ?? []) {
    ref.watch(blueskyPostPod(uri));
  }
}, dependencies: [blueskyTimelinePod, blueskyPostPod]);

class BlueskyTimelineNotifier extends _BlueskyFeedNotifier {
  @override
  Future<$atp.XRPCResponse<$bsky.Feed>> get(
    $bsky.Bluesky bluesky,
    String? cursor,
  ) {
    return bluesky.feed.getTimeline(cursor: cursor);
  }
}

abstract class _BlueskyFeedNotifier extends AsyncNotifier<List<$atp.AtUri>> {
  Future<$atp.XRPCResponse<$bsky.Feed>> get(
    $bsky.Bluesky bluesky,
    String? cursor,
  );

  String? _cursor;

  @override
  FutureOr<List<$atp.AtUri>> build() async {
    // 削除
    ref.listen(blueskySubscribePostDeletedPod, (_, uri) {
      if (uri == null) return;
      if (!state.hasValue) return;
      state = AsyncData([...state.value!..remove(uri)]);
    });
    // 追加
    final follows = await ref.watch(blueskySelfAndAllFollowsPod.future);
    ref.listen(blueskySubscribePostCreatedPod, (_, uri) {
      if (uri == null) return;
      if (!state.hasValue) return;
      if (follows.contains(uri.hostname)) {
        state = AsyncData([uri, ...state.value!]);
      }
    });

    return await _fetch();
  }

  Future<bool> more() async {
    if (_cursor == null) return false;
    final feed = await _fetch();
    state = AsyncData([...state.value!, ...feed]);
    return true;
  }

  Future<List<$atp.AtUri>> _fetch() async {
    final bluesky = await ref.watch(blueskyPod.future);
    final data = await bluesky.feed.getTimeline(cursor: _cursor, limit: 100);
    _cursor = data.data.cursor;
    for (final fv in data.data.feed) {
      final post = AsyncData(BlueskyPost.fromPost(fv.post));
      final author = AsyncData(BlueskyActor.fromActorBasic(fv.post.author));
      ref.read(blueskyPostCachePod(fv.post.uri).notifier).state = post;
      ref.read(blueskyActorCachePod(fv.post.author.did).notifier).state =
          author;
    }
    return data.data.feed.map((fv) => fv.post.uri).toList();
  }
}
