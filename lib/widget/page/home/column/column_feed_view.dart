import 'package:atproto/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skysoda/pod/bluesky/bluesky_feed_pod.dart';
import 'package:skysoda/widget/page/home/cell/cell_post_view.dart';

class ColumnFeedTimelineView extends _ColumnFeedView {
  const ColumnFeedTimelineView({super.key});

  @override
  AsyncValue<List<AtUri>> watchPod(WidgetRef ref) =>
      ref.watch(podBlueskyTimeline);
}

abstract class _ColumnFeedView extends ConsumerWidget {
  const _ColumnFeedView({super.key});

  AsyncValue<List<AtUri>> watchPod(WidgetRef ref);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return watchPod(ref).when(
      data: (feed) {
        return ListView.builder(
          itemCount: feed.length,
          itemBuilder: (context, index) {
            final uri = feed[index];
            return CellPostView(uri);
          },
        );
      },
      error: (error, st) => Center(child: Text(error.toString())),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}
