import 'package:atproto/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostActionsView extends ConsumerWidget {
  const PostActionsView(this.uri, {super.key});

  final AtUri uri;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(icon: Icon(Icons.replay), onPressed: () {}),
        IconButton(icon: Icon(Icons.refresh), onPressed: () {}),
        IconButton(icon: Icon(Icons.star), onPressed: () {}),
        IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
      ],
    );
  }
}
