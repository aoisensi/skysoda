import 'package:bluesky/bluesky.dart' as $bsky;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bluesky_post.freezed.dart';

@freezed
class BlueskyPost with _$BlueskyPost {
  const factory BlueskyPost({required String authorDid, required String text}) =
      _BlueskyPost;

  factory BlueskyPost.fromPost($bsky.Post v) {
    return BlueskyPost(authorDid: v.author.did, text: v.record.text);
  }
}
