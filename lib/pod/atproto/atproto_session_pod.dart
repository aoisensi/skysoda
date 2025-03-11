import 'package:atproto/atproto.dart' as $atp;
import 'package:atproto/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skysoda/pod/preference_pod.dart';

typedef AtprotoCredentials = (String, String, String);

final podAtprotoSession = FutureProvider.family
    .autoDispose<Session, (String, String, String)>((ref, args) async {
      return (await $atp.createSession(
        identifier: args.$1,
        password: args.$2,
      )).data;
    });

final podAtprotoSessions = FutureProvider.autoDispose<List<Session>>(
  (ref) async => Future.wait(
    ref
        .watch(podAtprotoCredentials)
        .map((c) => ref.watch(podAtprotoSession(c).future)),
  ),
);

final podAtprotoDids = FutureProvider.autoDispose<List<String>>((ref) async {
  return (await ref.watch(
    podAtprotoSessions.future,
  )).map((s) => s.did).toList();
});

final podAtproto = FutureProvider.family.autoDispose<Session, String>((
  ref,
  arg,
) async {
  return (await ref.watch(
    podAtprotoSessions.future,
  )).firstWhere((s) => s.did == arg);
});

final podAtprotoCredentials = Provider<List<AtprotoCredentials>>((ref) {
  return ref.watch(podPreferencesCredentials).map((c) {
    final cc = c.split('\$').toList();
    return (cc[0], cc[1], cc.elementAtOrNull(2) ?? '');
  }).toList();
});
