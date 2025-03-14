import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../pod/atproto/atproto_session_pod.dart';
import '../../../../pod/bluesky/bluesky_follow_pod.dart';
import '../cell/cell_actor_view.dart';

class ColumnFollowsView extends _ColumnActorsView {
  const ColumnFollowsView({super.key});

  @override
  AsyncValue<List<String>> watch(WidgetRef ref) {
    return ref.watch(blueskyFollowsPod(ref.watch(atprotoDidPod)));
  }
}

class ColumnFollowersView extends _ColumnActorsView {
  const ColumnFollowersView({super.key});

  @override
  AsyncValue<List<String>> watch(WidgetRef ref) {
    return ref.watch(blueskyFollowersPod(ref.watch(atprotoDidPod)));
  }
}

abstract class _ColumnActorsView extends ConsumerWidget {
  const _ColumnActorsView({super.key});

  AsyncValue<List<String>> watch(WidgetRef ref);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return watch(ref).when(
      data: (dids) {
        return ListView.builder(
          itemCount: dids.length,
          itemBuilder: (context, index) {
            return CellActorView(dids.elementAt(index));
          },
        );
      },
      error: (error, st) => Center(child: Text(error.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
