import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zoomies/core/constants/app_constants.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _usernameController = TextEditingController();
  final _petController = TextEditingController();
  String _tribe = AppConstants.tribes.first;
  String _avatar = '🐶';

  @override
  void dispose() {
    _usernameController.dispose();
    _petController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome to ZOOMIES')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(controller: _usernameController, decoration: const InputDecoration(labelText: 'Username')),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _tribe,
            items: AppConstants.tribes.map((tribe) => DropdownMenuItem(value: tribe, child: Text(tribe))).toList(),
            onChanged: (value) => setState(() => _tribe = value ?? _tribe),
            decoration: const InputDecoration(labelText: 'Tribe'),
          ),
          const SizedBox(height: 12),
          TextField(controller: _petController, decoration: const InputDecoration(labelText: 'Pet name')), 
          const SizedBox(height: 12),
          const Text('Choose illustrated avatar (no human faces):'),
          Wrap(
            spacing: 8,
            children: ['🐶', '🐱', '🐰', '🦊']
                .map(
                  (item) => ChoiceChip(
                    selected: _avatar == item,
                    label: Text(item, style: const TextStyle(fontSize: 24)),
                    onSelected: (_) => setState(() => _avatar = item),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () {
              if (_usernameController.text.isEmpty || _petController.text.isEmpty) {
                return;
              }
              context.go('/home');
            },
            child: const Text('Enter ZOOMIES'),
          ),
        ],
      ),
    );
  }
}
