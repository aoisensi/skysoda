import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ordered_set/ordered_set.dart';
import '../../entity/bluesky/bluesky_actor.dart';
import 'bluesky_actor_pod.dart';
import 'bluesky_session_pod.dart';

final blueskyFollowsPod = AsyncNotifierProvider.autoDispose
    .family<BlueskyFollowsNotifier, OrderedSet<String>, String>(
      BlueskyFollowsNotifier.new,
      dependencies: [blueskyPod],
    );

class BlueskyFollowsNotifier
    extends AutoDisposeFamilyAsyncNotifier<OrderedSet<String>, String> {
  @override
  FutureOr<OrderedSet<String>> build(String did) {
    return _fetch();
  }

  String? _cursor;

  Future<bool> more() async {
    if (_cursor == null) {
      return true;
    }
    state = AsyncData(state.value!..addAll(await _fetch()));
    return false;
  }

  Future<OrderedSet<String>> _fetch() async {
    final bluesky = await ref.watch(blueskyPod.future);
    final data = await bluesky.graph.getFollows(
      actor: arg,
      cursor: _cursor,
      limit: 100,
    );
    _cursor = data.data.cursor;
    final follows = data.data.follows;
    for (final actor in follows.map(BlueskyActor.fromActor)) {
      ref.watch(blueskyActorCachePod(actor.did).notifier).state = AsyncData(
        actor,
      );
    }

    return OrderedSet(null)..addAll(follows.map((e) => e.did));
  }
}
