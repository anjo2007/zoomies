import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoomies/features/create/presentation/providers/create_controller.dart';

class CreatePage extends ConsumerWidget {
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(createControllerProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('AI Audio Translator', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              alignment: Alignment.center,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Text('🐶', style: TextStyle(fontSize: 120)),
                  if (state.generatedCaption != null)
                    Positioned(
                      bottom: 20,
                      left: 20,
                      right: 20,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            state.generatedCaption!,
                            style: const TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text('Recording: ${state.currentDuration.inSeconds}s'),
          const SizedBox(height: 10),
          FilledButton.icon(
            onPressed: () {
              HapticFeedback.lightImpact();
              ref.read(createControllerProvider.notifier).toggleRecording();
            },
            icon: Icon(state.isRecording ? Icons.stop : Icons.mic),
            label: Text(state.isRecording ? 'Stop Recording & Generate Caption' : 'Record Audio'),
          ),
          const SizedBox(height: 8),
          const Text(
            '// TODO: Integrate ML Kit Face Detection to block human faces.',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
