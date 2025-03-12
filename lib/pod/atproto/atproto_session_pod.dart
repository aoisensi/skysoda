import 'package:atproto/atproto.dart' as $atp;
import 'package:atproto/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skysoda/pod/preference_pod.dart';

typedef AtprotoCredentials = (String, String, String);

final atprotoDidPod = Provider<String>((ref) => throw UnimplementedError());

final atprotoSessionPod = FutureProvider.family
    .autoDispose<Session, (String, String, String)>((ref, args) async {
      return (await $atp.createSession(
        identifier: args.$1,
        password: args.$2,
      )).data;
    });

final atprotoSessionsPod = FutureProvider.autoDispose<List<Session>>(
  (ref) async => Future.wait(
    ref
        .watch(atprotoCredentialsPod)
        .map((c) => ref.watch(atprotoSessionPod(c).future)),
  ),
);

final atprotoDidsPod = FutureProvider.autoDispose<List<String>>((ref) async {
  return (await ref.watch(
    atprotoSessionsPod.future,
  )).map((s) => s.did).toList();
});

final atprotoPod = FutureProvider.autoDispose<Session>((ref) async {
  final did = ref.watch(atprotoDidPod);
  return (await ref.watch(
    atprotoSessionsPod.future,
  )).firstWhere((s) => s.did == did);
}, dependencies: [atprotoDidPod]);

final atprotoCredentialsPod = Provider<List<AtprotoCredentials>>((ref) {
  return ref.watch(preferencesCredentialsPod).map((c) {
    final cc = c.split('\$').toList();
    return (cc[0], cc[1], cc.elementAtOrNull(2) ?? '');
  }).toList();
});
