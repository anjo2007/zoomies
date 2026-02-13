import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoomies/features/nap/presentation/providers/session_state_provider.dart';

class NapOverlay extends ConsumerWidget {
  const NapOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionStateProvider);
    final remaining = session.napUntil?.difference(DateTime.now());

    if (!session.shouldNap) {
      return const SizedBox.shrink();
    }

    final seconds = remaining == null ? 0 : remaining.inSeconds.clamp(0, 999);
    if (seconds <= 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(sessionStateProvider.notifier).acknowledgeNap();
      });
    }

    return Positioned.fill(
      child: AbsorbPointer(
        absorbing: true,
        child: Stack(
          fit: StackFit.expand,
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(color: Colors.black54),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('😴', style: TextStyle(fontSize: 56)),
                    const SizedBox(height: 12),
                    Text(
                      'Barnaby is sleepy. Close the app to let him rest.',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text('Unlocking in ${seconds}s'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
