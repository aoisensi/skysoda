import 'dart:async';

import 'package:atproto/core.dart' as $atp;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skysoda/entity/bluesky/bluesky_post.dart';
import 'package:skysoda/entity/bluesky/bluesky_profile.dart';
import 'package:skysoda/pod/bluesky/blueksy_post_pod.dart';
import 'package:skysoda/pod/bluesky/bluesky_profile_pod.dart';
import 'package:skysoda/pod/bluesky/bluesky_session_pod.dart';

final podBlueskyTimeline = AsyncNotifierProvider.autoDispose
    .family<BlueskyTimelinePod, List<$atp.AtUri>, (String,)>(
      BlueskyTimelinePod.new,
    );

class BlueskyTimelinePod
    extends AutoDisposeFamilyAsyncNotifier<List<$atp.AtUri>, (String,)> {
  @override
  FutureOr<List<$atp.AtUri>> build((String,) arg) {
    return _fetch();
  }

  Future<List<$atp.AtUri>> _fetch() async {
    final bluesky = await ref.watch(podBluesky(arg.$1).future);
    final data = await bluesky.feed.getTimeline();
    for (final fv in data.data.feed) {
      final post = BlueskyPost.fromPost(fv.post);
      final author = BlueskyProfile.fromActorBasic(fv.post.author);
      ref
          .read(podBlueskyPostCache(fv.post.uri).notifier)
          .state = AsyncValue.data(post);
      ref
          .read(podBlueskyProfileCache(fv.post.author.did).notifier)
          .state = AsyncValue.data(author);
    }
    return data.data.feed.map((e) => e.post.uri).toList();
  }
}
