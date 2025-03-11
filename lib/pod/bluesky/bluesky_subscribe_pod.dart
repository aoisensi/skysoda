import 'dart:async';

import 'package:atproto/core.dart';
import 'package:atproto/core.dart' as $atp;
import 'package:bluesky/atproto.dart';
import 'package:bluesky/ids.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skysoda/pod/atproto/atproto_session_pod.dart';
import 'package:skysoda/pod/atproto/atproto_subscribe_pod.dart';
import 'package:skysoda/pod/bluesky/bluesky_post_pod.dart';
import 'package:skysoda/pod/bluesky/bluesky_session_pod.dart';

final podBlueskyTimelinePublic =
    AsyncNotifierProvider<BlueskyTimelinePublicNotifier, List<$atp.AtUri>>(
      BlueskyTimelinePublicNotifier.new,
      dependencies: [podAtprotoDid, podAtproto, podBluesky],
    );

class BlueskyTimelinePublicNotifier extends AsyncNotifier<List<$atp.AtUri>> {
  @override
  FutureOr<List<AtUri>> build() async {
    final subscribes = await ref.watch(podAtprotoSubscribe.future);
    subscribes.commits.stream.listen((commit) async {
      final postOps =
          commit.ops
              .where((op) => op.uri.collection == NSID(appBskyFeedPost))
              .toList();
      final postCreatedOps =
          postOps.where((op) => op.action == RepoAction.create).toList();
      final postCreatedUris = postCreatedOps.map((op) => op.uri).toList();
      await BlueskyPostNotifier.fetchAll(ref, postCreatedUris);
      state = AsyncData([...postCreatedUris, ...state.value!]);
    });
    return [];
  }
}
