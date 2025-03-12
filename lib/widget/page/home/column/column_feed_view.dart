import 'package:atproto/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../pod/bluesky/bluesky_feed_pod.dart';
import '../cell/cell_post_view.dart';

class ColumnTimelineView extends _ColumnFeedView {
  const ColumnTimelineView({super.key});

  @override
  AsyncValue<List<AtUri>> watch(WidgetRef ref) {
    ref.watch(blueskyTimelineKeepAlivePod);
    return ref.watch(blueskyTimelinePod);
  }

  @override
  Future<bool> more(WidgetRef ref) =>
      ref.read(blueskyTimelinePod.notifier).more();
}

abstract class _ColumnFeedView extends HookConsumerWidget {
  const _ColumnFeedView({super.key});

  AsyncValue<List<AtUri>> watch(WidgetRef ref);
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
            return CellPostView(feed[index]);
          },
        );
      },
      error: (error, st) => Center(child: Text(error.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
