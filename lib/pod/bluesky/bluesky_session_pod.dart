import 'package:bluesky/bluesky.dart' as $bsky;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skysoda/pod/atproto/atproto_session_pod.dart';

final podBluesky = FutureProvider.family.autoDispose<$bsky.Bluesky, String>((
  ref,
  args,
) async {
  final session = await ref.watch(podAtproto(args).future);
  return $bsky.Bluesky.fromSession(session);
});
