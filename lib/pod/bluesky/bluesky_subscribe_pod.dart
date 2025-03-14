import 'package:bluesky/bluesky.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final blueskySubscribePostCreatedPod =
    StateProvider<RepoCommitCreate<PostRecord>?>((ref) => null);
final blueskySubscribePostDeletedPod = StateProvider<RepoCommitDelete?>(
  (ref) => null,
);
final blueskySubscribeRepostCreatedPod =
    StateProvider<RepoCommitCreate<RepostRecord>?>((ref) => null);
final blueskySubscribeRepostDeletedPod = StateProvider<RepoCommitDelete?>(
  (ref) => null,
);
