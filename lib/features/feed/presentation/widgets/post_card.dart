import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoomies/features/feed/domain/models/post.dart';
import 'package:zoomies/features/feed/presentation/providers/feed_controller.dart';
import 'package:zoomies/features/feed/presentation/widgets/treat_burst.dart';

class PostCard extends ConsumerStatefulWidget {
  const PostCard({required this.post, super.key});

  final Post post;

  @override
  ConsumerState<PostCard> createState() => _PostCardState();
}

class _PostCardState extends ConsumerState<PostCard> {
  bool _showBurst = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 9 / 14,
            child: CachedNetworkImage(
              imageUrl: widget.post.mediaUrl,
              fit: BoxFit.cover,
              placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
              errorWidget: (_, __, ___) => const Center(child: Icon(Icons.image_not_supported)),
            ),
          ),
          Positioned(
            left: 12,
            right: 12,
            bottom: 12,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.post.aiCaption,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        if (_showBurst) const TreatBurst(),
                        IconButton(
                          onPressed: () async {
                            HapticFeedback.lightImpact();
                            setState(() => _showBurst = true);
                            await ref.read(feedControllerProvider.notifier).giveTreat(widget.post.id);
                            if (mounted) {
                              await Future<void>.delayed(const Duration(milliseconds: 450));
                              setState(() => _showBurst = false);
                            }
                          },
                          icon: const Text('🦴', style: TextStyle(fontSize: 18)),
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Text(
                      '${widget.post.treatCount}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
