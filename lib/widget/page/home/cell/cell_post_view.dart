import 'package:atproto/core.dart' as $atp;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skysoda/pod/bluesky/blueksy_post_pod.dart';
import 'package:skysoda/pod/bluesky/bluesky_profile_pod.dart';

class CellPostView extends ConsumerWidget {
  const CellPostView(this.did, this.uri, {super.key});

  final String did;
  final $atp.AtUri uri;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ref
          .watch(podBlueskyPost((did, uri)))
          .when(
            data: (post) {
              return Column(
                children: [
                  ref
                      .watch(podBlueskyProfile((did, post.authorDid)))
                      .when(
                        data:
                            (profile) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(profile.avatar),
                              ),
                              title: Text(profile.displayName),
                              subtitle: Text(profile.handle),
                            ),
                        error:
                            (error, st) =>
                                ListTile(title: Text(error.toString())),
                        loading:
                            () =>
                                ListTile(leading: CircularProgressIndicator()),
                      ),
                  Text(post.text),
                ],
              );
            },
            error: (error, st) => Center(child: Text(error.toString())),
            loading: () => Center(child: CircularProgressIndicator()),
          ),
    );
  }
}
