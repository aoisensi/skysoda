import 'dart:async';

import 'package:atproto/atproto.dart' as $atp;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final atprotoSubscribePod = FutureProvider<SubscribeStreams>((ref) async {
  final streams = SubscribeStreams();
  final atproto = $atp.ATProto.anonymous();
  final subscribe = await atproto.sync.subscribeRepos();
  subscribe.data.stream.listen((payload) {
    payload.maybeWhen(
      commit: (data) {
        streams.commits.add(data);
      },
      orElse: () {},
    );
  });
  return streams;
});

class SubscribeStreams {
  final StreamController<$atp.Commit> commits = StreamController();
}
