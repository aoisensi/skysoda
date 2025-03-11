import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skysoda/pod/atproto/atproto_session_pod.dart';
import 'package:skysoda/widget/page/home/column/column_timeline_view.dart';

final _podColumns = Provider<List<Widget>>((ref) {
  return [const ColumnTimelineHomeView()];
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(podAtprotoDids)
        .when(
          data: (dids) {
            return MediaQuery.sizeOf(context).width < 600
                ? const _SmallHomePage()
                : const _LargeHomePage();
          },
          error: (error, st) => Center(child: Text(error.toString())),
          loading: () => Center(child: CircularProgressIndicator()),
        );
  }
}

class _LargeHomePage extends ConsumerWidget {
  const _LargeHomePage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final columns = ref.watch(_podColumns);
    return Scaffold(
      body: ref
          .watch(podAtprotoSessions)
          .when(
            data: (sessions) {
              return ListView(
                scrollDirection: Axis.horizontal,
                children:
                    columns.map((builder) {
                      return SizedBox(
                        width: 360.0,
                        child: ProviderScope(
                          overrides: [
                            podAtprotoDid.overrideWithValue(sessions.first.did),
                          ],
                          child: builder,
                        ),
                      );
                    }).toList(),
              );
            },
            error: (error, st) => Center(child: Text(error.toString())),
            loading: () => Center(child: CircularProgressIndicator()),
          ),
    );
  }
}

class _SmallHomePage extends ConsumerWidget {
  const _SmallHomePage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final columns = ref.watch(_podColumns);
    return Scaffold(
      body: ref
          .watch(podAtprotoSessions)
          .when(
            data: (sessions) {
              return PageView(
                children:
                    columns.map((builder) {
                      return ProviderScope(
                        overrides: [
                          podAtprotoDid.overrideWithValue(sessions.first.did),
                        ],
                        child: builder,
                      );
                    }).toList(),
              );
            },
            error: (error, st) => Center(child: Text(error.toString())),
            loading: () => Center(child: CircularProgressIndicator()),
          ),
    );
  }
}
