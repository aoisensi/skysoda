import 'package:atproto/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skysoda/pod/bluesky/bluesky_subscribe_pod.dart';
import 'package:skysoda/pod/bluesky/bluesky_feed_pod.dart';
import 'package:skysoda/widget/page/home/cell/cell_post_view.dart';

class ColumnTimelineHomeView extends _ColumnTimelineView {
  const ColumnTimelineHomeView({super.key});

  @override
  AsyncValue<List<AtUri>> watchPod(WidgetRef ref) =>
      ref.watch(podBlueskyTimeline);
}

class ColumnTimelinePublicView extends _ColumnTimelineView {
  const ColumnTimelinePublicView({super.key});

  @override
  AsyncValue<List<AtUri>> watchPod(WidgetRef ref) =>
      ref.watch(podBlueskyTimelinePublic);
}

abstract class _ColumnTimelineView extends ConsumerWidget {
  const _ColumnTimelineView({super.key});

  AsyncValue<List<AtUri>> watchPod(WidgetRef ref);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return watchPod(ref).when(
      data: (timeline) {
        return ListView.builder(
          itemCount: timeline.length,
          itemBuilder: (context, index) {
            final uri = timeline[index];
            return CellPostView(uri);
          },
        );
      },
      error: (error, st) => Center(child: Text(error.toString())),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}
