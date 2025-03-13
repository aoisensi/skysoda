import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../atproto/atproto_session_pod.dart';
import 'bluesky_actor_pod.dart';
import 'bluesky_session_pod.dart';

import '../../entity/bluesky/bluesky_actor.dart';

final blueskyFollowsPod = AsyncNotifierProvider.autoDispose
    .family<BlueskyFollowsNotifier, List<String>, String>(
      () => BlueskyFollowsNotifier(true),
      dependencies: [blueskyPod],
    );

final blueskyFollowersPod = AsyncNotifierProvider.autoDispose
    .family<BlueskyFollowsNotifier, List<String>, String>(
      () => BlueskyFollowsNotifier(false),
      dependencies: [blueskyPod],
    );

class BlueskyFollowsNotifier
    extends AutoDisposeFamilyAsyncNotifier<List<String>, String> {
  BlueskyFollowsNotifier(this.isFollower);

  final bool isFollower;

  String? _cursor;

  @override
  FutureOr<List<String>> build(String did) {
    return _fetch();
  }

  Future<bool> more() async {
    if (_cursor == null) {
      return false;
    }
    state = AsyncData([...state.value!, ...await _fetch()]);
    return true;
  }

  Future<List<String>> _fetch() async {
    final bluesky = await ref.watch(blueskyPod.future);
    if (isFollower) {}
    final actors =
        await (isFollower
            ? () async {
              final data = await bluesky.graph.getFollows(
                actor: arg,
                cursor: _cursor,
                limit: 100,
              );
              _cursor = data.data.cursor;
              return data.data.follows;
            }()
            : () async {
              final data = await bluesky.graph.getFollowers(
                actor: arg,
                cursor: _cursor,
                limit: 100,
              );
              _cursor = data.data.cursor;
              return data.data.followers;
            }());

    for (final actor in actors.map(BlueskyActor.fromActor)) {
      ref.watch(blueskyActorCachePod(actor.did).notifier).state = AsyncData(
        actor,
      );
    }

    return actors.map((e) => e.did).toList();
  }
}

final blueskySelfAndAllFollowsPod = FutureProvider((ref) async {
  final self = ref.watch(atprotoDidPod);
  while (true) {
    final actors = await ref.watch(blueskyFollowsPod(self).future);
    if (!await ref.watch(blueskyFollowsPod(self).notifier).more()) {
      return actors..add(self);
    }
  }
}, dependencies: [atprotoDidPod, blueskyFollowsPod]);
