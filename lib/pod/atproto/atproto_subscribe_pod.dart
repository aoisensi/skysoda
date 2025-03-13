import 'package:atproto/atproto.dart' as $atp;
import 'package:atproto/core.dart';
import 'package:bluesky/atproto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../bluesky/bluesky_subscribe_pod.dart';

final atprotoSubscribePod = StreamProvider<Null>((ref) async* {
  final atproto = $atp.ATProto.anonymous();
  final subscribe = await atproto.sync.subscribeRepos();
  subscribe.data.stream.listen((payload) {
    payload.maybeWhen(
      commit: (data) {
        for (final op in data.ops) {
          switch (op.uri.collection) {
            case const NSID('app.bsky.feed.post'):
              switch (op.action) {
                case RepoAction.create:
                  ref.read(blueskySubscribePostCreatedPod.notifier).state =
                      op.uri;
                case RepoAction.delete:
                  ref.read(blueskySubscribePostDeletedPod.notifier).state =
                      op.uri;
                default:
                  break;
              }
              break;
            default:
              break;
          }
        }
      },
      orElse: () {},
    );
  });
});
