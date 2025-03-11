import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skysoda/entity/bluesky/bluesky_actor.dart';
import 'package:skysoda/pod/bluesky/bluesky_actor_pod.dart';
import 'package:skysoda/pod/bluesky/bluesky_session_pod.dart';

final podBlueskyFollows = AsyncNotifierProvider.autoDispose
    .family<BlueskyFollowsNotifier, List<String>, String>(
      BlueskyFollowsNotifier.new,
      dependencies: [podBluesky],
    );

class BlueskyFollowsNotifier
    extends AutoDisposeFamilyAsyncNotifier<List<String>, String> {
  @override
  FutureOr<List<String>> build(String did) {
    return _fetch();
  }

  String? _cursor;

  Future<bool> more() async {
    if (_cursor == null) {
      return true;
    }
    state = AsyncData([...state.value!, ...await _fetch()]);
    return false;
  }

  Future<List<String>> _fetch() async {
    final bluesky = await ref.watch(podBluesky.future);
    final data = await bluesky.graph.getFollows(
      actor: arg,
      cursor: _cursor,
      limit: 100,
    );
    _cursor = data.data.cursor;
    final follows = data.data.follows;
    for (final actor in follows.map(BlueskyActor.fromActor)) {
      ref.watch(podBlueskyActorCache(actor.did).notifier).state = AsyncData(
        actor,
      );
    }

    return follows.map((e) => e.did).toList();
  }
}
