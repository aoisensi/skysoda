import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skysoda/pod/bluesky/bluesky_actor_pod.dart';

class ActorTileView extends ConsumerWidget {
  const ActorTileView(this.did, {super.key});

  final String did;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(podBlueskyActor(did))
        .when(
          data: (profile) {
            return ListTile(
              leading:
                  profile.avatar != null
                      ? CircleAvatar(
                        backgroundImage: NetworkImage(profile.avatar!),
                      )
                      : CircleAvatar(
                        child: Text(
                          profile.displayName?.substring(
                                0,
                                min(2, profile.displayName!.length),
                              ) ??
                              "",
                        ),
                      ),
              title: Text(profile.displayName ?? profile.handle),
              subtitle: Text("@${profile.handle}"),
            );
          },
          error: (error, st) => ListTile(title: Text(error.toString())),
          loading: () => ListTile(leading: CircularProgressIndicator()),
        );
  }
}
