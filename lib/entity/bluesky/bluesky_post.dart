import 'package:atproto/core.dart';
import 'package:bluesky/bluesky.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bluesky_post.freezed.dart';

@freezed
class BlueskyPost with _$BlueskyPost {
  const factory BlueskyPost({
    required String did,
    required String text,
    required AtUri uri,
  }) = _BlueskyPost;

  factory BlueskyPost.fromPost(Post v) {
    return BlueskyPost(did: v.author.did, text: v.record.text, uri: v.uri);
  }

  factory BlueskyPost.fromPostRecord(RepoCommitCreate<PostRecord> v) {
    return BlueskyPost(did: v.author, text: v.record.text, uri: v.uri);
  }
}
