import 'package:atproto/core.dart' as $atp;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skysoda/pod/bluesky/bluesky_post_pod.dart';
import 'package:skysoda/widget/page/home/view/actor_tile_view.dart';
import 'package:skysoda/widget/page/home/view/post_actions_view.dart';

class CellPostView extends ConsumerWidget {
  const CellPostView(this.uri, {super.key});

  final $atp.AtUri uri;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ref
          .watch(podBlueskyPost(uri))
          .when(
            data: (post) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ActorTileView(post.authorDid),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(post.text),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: PostActionsView(uri),
                  ),
                ],
              );
            },
            error: (error, st) => Text(error.toString()),
            loading: () => Center(child: CircularProgressIndicator()),
          ),
    );
  }
}
