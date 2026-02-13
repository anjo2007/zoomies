import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoomies/features/den/presentation/providers/den_controller.dart';

class DenPage extends ConsumerWidget {
  const DenPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pet = ref.watch(denControllerProvider);
    final controller = ref.read(denControllerProvider.notifier);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('The Den', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
          child: Column(
            children: [
              const Text('🐾', style: TextStyle(fontSize: 80)),
              Text(pet.name, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              LinearProgressIndicator(value: pet.energyLevel),
              const SizedBox(height: 8),
              Text('Energy ${(pet.energyLevel * 100).round()}%'),
              Text('Social ${pet.social}'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text('Kibble: ${pet.kibble}'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FilledButton(onPressed: controller.buyRug, child: const Text('Buy Rug (50)')),
            FilledButton(onPressed: controller.buyHat, child: const Text('Buy Hat (30)')),
            OutlinedButton(onPressed: controller.gainSocial, child: const Text('Social +1')),
          ],
        ),
        const SizedBox(height: 10),
        Text('Decor: ${pet.decor}'),
      ],
    );
  }
}
