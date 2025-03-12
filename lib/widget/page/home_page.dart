import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../pod/atproto/atproto_session_pod.dart';
import 'home/column/column_actors_view.dart';
import 'home/column/column_feed_view.dart';

final _podColumns = Provider<List<Widget>>((ref) {
  return [const ColumnTimelineView(), const ColumnFollowsView()];
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(atprotoDidsPod)
        .when(
          data: (dids) {
            return MediaQuery.sizeOf(context).width < 600
                ? const _SmallHomePage()
                : const _LargeHomePage();
          },
          error: (error, st) => Center(child: Text(error.toString())),
          loading: () => const Center(child: CircularProgressIndicator()),
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
          .watch(atprotoSessionsPod)
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
                            atprotoDidPod.overrideWithValue(sessions.first.did),
                          ],
                          child: builder,
                        ),
                      );
                    }).toList(),
              );
            },
            error: (error, st) => Center(child: Text(error.toString())),
            loading: () => const Center(child: CircularProgressIndicator()),
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
          .watch(atprotoSessionsPod)
          .when(
            data: (sessions) {
              return PageView(
                children:
                    columns.map((builder) {
                      return ProviderScope(
                        overrides: [
                          atprotoDidPod.overrideWithValue(sessions.first.did),
                        ],
                        child: builder,
                      );
                    }).toList(),
              );
            },
            error: (error, st) => Center(child: Text(error.toString())),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
    );
  }
}
