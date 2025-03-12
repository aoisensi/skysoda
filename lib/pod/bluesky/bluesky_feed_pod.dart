import 'dart:async';

import 'package:atproto/core.dart' as $atp;
import 'package:bluesky/bluesky.dart' as $bsky;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skysoda/entity/bluesky/bluesky_post.dart';
import 'package:skysoda/entity/bluesky/bluesky_actor.dart';
import 'package:skysoda/pod/atproto/atproto_session_pod.dart';
import 'package:skysoda/pod/bluesky/bluesky_post_pod.dart';
import 'package:skysoda/pod/bluesky/bluesky_actor_pod.dart';
import 'package:skysoda/pod/bluesky/bluesky_session_pod.dart';

final podBlueskyTimeline =
    AsyncNotifierProvider<BlueskyTimelineNotifier, List<$atp.AtUri>>(
      BlueskyTimelineNotifier.new,
      dependencies: [podAtprotoDid, podAtproto, podBluesky],
    );

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
    return await _fetch();
  }

  Future<bool> more() async {
    if (_cursor == null) return false;
    final feed = await _fetch();
    state = AsyncData([...state.value!, ...feed]);
    return true;
  }

  Future<List<$atp.AtUri>> _fetch() async {
    final bluesky = await ref.watch(podBluesky.future);
    final data = await bluesky.feed.getTimeline(cursor: _cursor, limit: 100);
    _cursor = data.data.cursor;
    for (final fv in data.data.feed) {
      final post = BlueskyPost.fromPost(fv.post);
      final author = BlueskyActor.fromActorBasic(fv.post.author);
      ref
          .read(podBlueskyPostCache(fv.post.uri).notifier)
          .state = AsyncValue.data(post);
      ref
          .read(podBlueskyActorCache(fv.post.author.did).notifier)
          .state = AsyncValue.data(author);
    }
    return data.data.feed.map((fv) {
      return fv.post.uri;
    }).toList();
  }
}
