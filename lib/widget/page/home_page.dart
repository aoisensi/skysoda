import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skysoda/pod/atproto/atproto_session_pod.dart';
import 'package:skysoda/widget/page/home/column/column_timeline_view.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: ref
          .watch(podAtprotoSessions)
          .when(
            data: (sessions) {
              return ProviderScope(
                overrides: [
                  podAtprotoDid.overrideWithValue(sessions.first.did),
                ],
                child: const ColumnTimelineView(),
              );
            },
            error: (error, st) => Center(child: Text(error.toString())),
            loading: () => Center(child: CircularProgressIndicator()),
          ),
    );
  }
}
