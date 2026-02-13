import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoomies/features/feed/domain/models/post.dart';
import 'package:zoomies/features/feed/domain/repositories/post_repository.dart';

final postRepositoryProvider = Provider<PostRepository>((ref) {
  return MockPostRepository();
});

class MockPostRepository implements PostRepository {
  static final List<Post> _seed = List.generate(
    80,
    (index) => Post(
      id: 'post_$index',
      authorId: 'user_${index % 7}',
      mediaUrl: 'https://picsum.photos/seed/zoomies$index/900/1400',
      aiCaption: index.isEven ? 'The cheese tax must be paid.' : 'No thoughts, just zoomies.',
      audioUrl: 'mock://audio/$index',
      treatCount: Random(index).nextInt(500),
      timestamp: DateTime.now().subtract(Duration(minutes: index * 5)),
    ),
  );

  @override
  Future<List<Post>> fetchPosts({String? lastPostId, int limit = 10}) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));

    var startIndex = 0;
    if (lastPostId != null) {
      final current = _seed.indexWhere((p) => p.id == lastPostId);
      startIndex = current >= 0 ? current + 1 : 0;
    }

    final end = (startIndex + limit).clamp(0, _seed.length);
    return _seed.sublist(startIndex, end);
  }

  @override
  Future<void> incrementTreat(String postId) async {
    final index = _seed.indexWhere((p) => p.id == postId);
    if (index < 0) {
      return;
    }
    _seed[index] = _seed[index].copyWith(treatCount: _seed[index].treatCount + 1);
  }
}
