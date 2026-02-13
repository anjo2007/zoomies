import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoomies/features/feed/presentation/providers/feed_controller.dart';
import 'package:zoomies/features/feed/presentation/widgets/post_card.dart';
import 'package:zoomies/features/nap/presentation/providers/session_state_provider.dart';

class SniffFeedPage extends ConsumerWidget {
  const SniffFeedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(feedControllerProvider);

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification) {
          ref.read(sessionStateProvider.notifier).registerScroll();
        }

        if (notification.metrics.pixels > notification.metrics.maxScrollExtent - 100) {
          ref.read(feedControllerProvider.notifier).loadMore();
        }
        return false;
      },
      child: ListView.builder(
        itemCount: state.posts.length + (state.loading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= state.posts.length) {
            return const Padding(
              padding: EdgeInsets.all(24),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          return PostCard(post: state.posts[index]);
        },
      ),
    );
  }
}
