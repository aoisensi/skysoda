import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view/actor_tile_view.dart';

class CellActorView extends ConsumerWidget {
  const CellActorView(this.did, {super.key});

  final String did;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(child: ActorTileView(did));
  }
}
