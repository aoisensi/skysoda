import 'package:bluesky/bluesky.dart' as $bsky;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skysoda/pod/atproto/atproto_session_pod.dart';

final podBluesky = FutureProvider.autoDispose<$bsky.Bluesky>((ref) async {
  final session = await ref.watch(podAtproto.future);
  return $bsky.Bluesky.fromSession(session);
}, dependencies: [podAtprotoDid, podAtproto]);
