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

// (Re)Post identifier
// Maybe it will became class
typedef Pid = ($atp.AtUri, String?);

final blueskyTimelinePod = Provider((ref) {
  final feed = ref.watch(blueskyTimelineNotifierPod(null));
  // for keep alive
  feed.valueOrNull?.forEach((uri) => ref.watch(blueskyPostPod(uri.$1)));
  return feed;
}, dependencies: [blueskyTimelineNotifierPod, blueskyPostPod]);

final blueskyTimelineNotifierPod =
    AsyncNotifierProvider.family<BlueskyTimelineNotifier, List<Pid>, Null>(
      BlueskyTimelineNotifier.new,
      dependencies: [
        atprotoDidPod,
        atprotoPod,
        blueskyPod,
        blueskySelfAndAllFollowsPod,
      ],
    );

final blueskyAuthorFeedPod = Provider.family((ref, String arg) {
  final feed = ref.watch(blueskyAuthorFeedNotifierPod(arg));
  feed.valueOrNull?.forEach((uri) => ref.watch(blueskyPostPod(uri.$1)));
  return feed;
}, dependencies: [blueskyAuthorFeedNotifierPod, blueskyPostPod]);

final blueskyAuthorFeedNotifierPod =
    AsyncNotifierProvider.family<BlueskyAuthorFeedNotifier, List<Pid>, String>(
      BlueskyAuthorFeedNotifier.new,
      dependencies: [atprotoDidPod, atprotoPod, blueskyPod],
    );

class BlueskyTimelineNotifier extends _BlueskyFeedNotifier<Null> {
  @override
  Future<$atp.XRPCResponse<$bsky.Feed>> fetch(
    $bsky.Bluesky bluesky,
    String? cursor,
  ) {
    return bluesky.feed.getTimeline(cursor: cursor, limit: 100);
  }

  @override
  Future<void> subscribe() async {
    final follows = await ref.watch(blueskySelfAndAllFollowsPod.future);
    // 削除
    ref.listen(blueskySubscribePostDeletedPod, (_, commit) {
      if (commit == null) return;
      if (!state.hasValue) return;
      state = AsyncData([
        ...state.value!..removeWhere((v) => v.$1 == commit.uri),
      ]);
    });
    // ref.listen(blueskySubscribeRepostDeletedPod, (_, commit) {
    //   if (commit == null) return;
    //   if (!state.hasValue) return;
    //   state = AsyncData([...state.value!..remove((commit., commit.author))]);
    // });
    // 追加
    ref.listen(blueskySubscribePostCreatedPod, (_, commit) {
      if (commit == null) return;
      if (!state.hasValue) return;
      if (follows.contains(commit.author)) {
        ref.read(blueskyPostCachePod(commit.uri).notifier).state = AsyncData(
          BlueskyPost.fromPostRecord(commit),
        );
        state = AsyncData([(commit.uri, null), ...state.value!]);
      }
    });
    ref.listen(blueskySubscribeRepostCreatedPod, (_, commit) {
      if (commit == null) return;
      if (!state.hasValue) return;
      if (follows.contains(commit.author)) {
        state = AsyncData([
          (commit.record.ref.uri, commit.author),
          ...state.value!,
        ]);
      }
    });
  }
}

class BlueskyAuthorFeedNotifier extends _BlueskyFeedNotifier<String> {
  @override
  Future<$atp.XRPCResponse<$bsky.Feed>> fetch(
    $bsky.Bluesky bluesky,
    String? cursor,
  ) {
    return bluesky.feed.getAuthorFeed(actor: arg, limit: 100);
  }

  @override
  Future<void> subscribe() async {
    ref.listen(blueskySubscribePostDeletedPod, (_, commit) {
      if (commit == null) return;
      if (!state.hasValue) return;
      state = AsyncData([
        ...state.value!..removeWhere((v) => v.$1 == commit.uri),
      ]);
    });
    // ref.listen(blueskySubscribeRepostDeletedPod, (_, commit) {
    //   if (commit == null) return;
    //   if (!state.hasValue) return;
    //   state = AsyncData([...state.value!..remove((commit.uri, commit.author))]);
    // });
    // 追加
    ref.listen(blueskySubscribePostCreatedPod, (_, commit) {
      if (commit == null) return;
      if (!state.hasValue) return;
      if (commit.author == arg) {
        ref.read(blueskyPostCachePod(commit.uri).notifier).state = AsyncData(
          BlueskyPost.fromPostRecord(commit),
        );
        state = AsyncData([(commit.uri, null), ...state.value!]);
      }
    });
    ref.listen(blueskySubscribeRepostCreatedPod, (_, commit) {
      if (commit == null) return;
      if (!state.hasValue) return;
      if (commit.author == arg) {
        state = AsyncData([
          (commit.record.ref.uri, commit.author),
          ...state.value!,
        ]);
      }
    });
  }
}

abstract class _BlueskyFeedNotifier<Arg>
    extends FamilyAsyncNotifier<List<Pid>, Arg> {
  Future<$atp.XRPCResponse<$bsky.Feed>> fetch(
    $bsky.Bluesky bluesky,
    String? cursor,
  );

  Future<void> subscribe();

  String? _cursor;

  @override
  FutureOr<List<Pid>> build(Arg arg) async {
    await subscribe();
    return await _fetch();
  }

  Future<bool> more() async {
    if (_cursor == null) return false;
    final feed = await _fetch();
    state = AsyncData([...state.value!, ...feed]);
    return true;
  }

  Future<List<Pid>> _fetch() async {
    final bluesky = await ref.watch(blueskyPod.future);
    final data = await fetch(bluesky, _cursor);
    _cursor = data.data.cursor;
    for (final fv in data.data.feed) {
      BlueskyPostNotifier.storeFeedView(ref, fv);
      final author = AsyncData(BlueskyActor.fromActorBasic(fv.post.author));
      ref.read(blueskyActorCachePod(fv.post.author.did).notifier).state =
          author;
    }
    return data.data.feed
        .map(
          (fv) => (
            fv.post.uri,
            (fv.reason?.data as $bsky.ReasonRepost?)?.by.did,
          ),
        )
        .toList();
  }
}
