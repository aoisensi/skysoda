import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skysoda/pod/bluesky/bluesky_timeline_pod.dart';
import 'package:skysoda/widget/page/home/cell/cell_post_view.dart';

class ColumnTimelineView extends ConsumerWidget {
  const ColumnTimelineView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(podBlueskyTimeline)
        .when(
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
