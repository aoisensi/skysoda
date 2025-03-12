import 'package:bluesky/bluesky.dart' as $bsky;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../atproto/atproto_session_pod.dart';

final blueskyPod = FutureProvider.autoDispose<$bsky.Bluesky>((ref) async {
  final session = await ref.watch(atprotoPod.future);
  return $bsky.Bluesky.fromSession(session);
}, dependencies: [atprotoDidPod, atprotoPod]);
