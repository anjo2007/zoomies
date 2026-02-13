import 'package:zoomies/features/feed/domain/models/post.dart';

abstract class PostRepository {
  Future<List<Post>> fetchPosts({String? lastPostId, int limit = 10});
  Future<void> incrementTreat(String postId);
}
