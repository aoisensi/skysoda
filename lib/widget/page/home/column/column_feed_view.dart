import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../pod/bluesky/bluesky_feed_pod.dart';
import '../cell/cell_post_view.dart';

class ColumnTimelineView extends _ColumnFeedView {
  const ColumnTimelineView({super.key});

  @override
  AsyncValue<List<Pid>> watch(WidgetRef ref) => ref.watch(blueskyTimelinePod);

  @override
  Future<bool> more(WidgetRef ref) =>
      ref.read(blueskyTimelineNotifierPod(null).notifier).more();
}

class ColumnAuthorFeedView extends _ColumnFeedView {
  const ColumnAuthorFeedView(this.did, {super.key});

  final String did;

  @override
  AsyncValue<List<Pid>> watch(WidgetRef ref) =>
      ref.watch(blueskyAuthorFeedPod(did));

  @override
  Future<bool> more(WidgetRef ref) =>
      ref.watch(blueskyAuthorFeedNotifierPod(did).notifier).more();
}

abstract class _ColumnFeedView extends HookConsumerWidget {
  const _ColumnFeedView({super.key});

  AsyncValue<List<Pid>> watch(WidgetRef ref);
  Future<bool> more(WidgetRef ref);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFinished = useState(false);
    return watch(ref).when(
      data: (feed) {
        return ListView.builder(
          itemCount: feed.length + 1,
          itemBuilder: (context, index) {
            if (index == feed.length) {
              if (isFinished.value) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('・'),
                  ),
                );
              }
              more(ref).then((value) {
                if (!value) isFinished.value = true;
              });
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return CellPostView(feed.elementAt(index));
          },
        );
      },
      error: (error, st) => Center(child: Text(error.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
