import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoomies/features/feed/data/repositories/mock_post_repository.dart';
import 'package:zoomies/features/feed/domain/models/post.dart';

class FeedState {
  const FeedState({
    this.posts = const [],
    this.loading = false,
    this.hasMore = true,
  });

  final List<Post> posts;
  final bool loading;
  final bool hasMore;

  FeedState copyWith({List<Post>? posts, bool? loading, bool? hasMore}) {
    return FeedState(
      posts: posts ?? this.posts,
      loading: loading ?? this.loading,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

class FeedController extends StateNotifier<FeedState> {
  FeedController(this._ref) : super(const FeedState()) {
    loadInitial();
  }

  final Ref _ref;

  Future<void> loadInitial() async {
    if (state.loading) {
      return;
    }
    state = state.copyWith(loading: true);
    final repo = _ref.read(postRepositoryProvider);
    final posts = await repo.fetchPosts(limit: 10);
    state = state.copyWith(posts: posts, loading: false, hasMore: posts.isNotEmpty);
  }

  Future<void> loadMore() async {
    if (state.loading || !state.hasMore || state.posts.isEmpty) {
      return;
    }
    state = state.copyWith(loading: true);
    final repo = _ref.read(postRepositoryProvider);
    final more = await repo.fetchPosts(lastPostId: state.posts.last.id, limit: 10);
    state = state.copyWith(
      posts: [...state.posts, ...more],
      loading: false,
      hasMore: more.isNotEmpty,
    );
  }

  Future<void> giveTreat(String postId) async {
    final repo = _ref.read(postRepositoryProvider);
    await repo.incrementTreat(postId);
    state = state.copyWith(
      posts: state.posts
          .map((post) => post.id == postId ? post.copyWith(treatCount: post.treatCount + 1) : post)
          .toList(growable: false),
    );
  }
}

final feedControllerProvider = StateNotifierProvider<FeedController, FeedState>((ref) {
  return FeedController(ref);
});
