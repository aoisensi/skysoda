import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../pod/bluesky/bluesky_actor_pod.dart';
import '../../../../pod/bluesky/bluesky_feed_pod.dart';
import '../../../../pod/bluesky/bluesky_post_pod.dart';
import '../view/actor_tile_view.dart';
import '../view/post_actions_view.dart';

class CellPostView extends ConsumerWidget {
  const CellPostView(this.pid, {super.key});

  final Pid pid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reposterDid = pid.$2;
    return Card(
      child: ref
          .watch(blueskyPostPod(pid.$1))
          .when(
            data: (post) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (reposterDid != null) _CellPostViewRepost(reposterDid),
                  Padding(
                    padding: EdgeInsets.zero, // symmetric(horizontal: 16.0),
                    child: ActorTileView(post.did),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(post.text),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  //   child: Text(post.uri.toString()),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PostActionsView(pid.$1),
                  ),
                ],
              );
            },
            error: (error, st) => Text(error.toString()),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
    );
  }
}

class _CellPostViewRepost extends ConsumerWidget {
  const _CellPostViewRepost(this.did);

  final String did;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(blueskyActorPod(did)).value?.displayName ?? 'null';
    return Padding(
      padding: const EdgeInsets.only(left: 68.0, right: 16.0),
      child: Text('Reposted by $name'),
    );
  }
}
