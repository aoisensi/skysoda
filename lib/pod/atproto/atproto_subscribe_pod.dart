import 'package:atproto/atproto.dart' as $atp;
import 'package:bluesky/bluesky.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../bluesky/bluesky_subscribe_pod.dart';

final atprotoSubscribePod = StreamProvider<Null>((ref) async* {
  final atproto = $atp.ATProto.anonymous();
  final subscribe = await atproto.sync.subscribeRepos();
  final onCreatePost = ref.watch(blueskySubscribePostCreatedPod.notifier);
  final onDeletePost = ref.watch(blueskySubscribePostDeletedPod.notifier);
  // final onCreateRepost = ref.watch(blueskySubscribeRepostCreatedPod.notifier);
  // final onDeleteRepost = ref.watch(blueskySubscribeRepostDeletedPod.notifier);
  final repoCommitAdapter = RepoCommitAdaptor(
    onCreatePost: (data) => onCreatePost.state = data,
    onDeletePost: (data) => onDeletePost.state = data,
    // onCreateRepost: (data) => onCreateRepost.state = data,
    // onDeleteRepost: (data) => onDeleteRepost.state = data,
  );
  await for (final payload in subscribe.data.stream) {
    payload.maybeWhen(commit: repoCommitAdapter.execute, orElse: () {});
  }
});
