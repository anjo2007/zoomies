import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:zoomies/features/nap/presentation/widgets/nap_overlay.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  void _onTap(int index) {
    navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    const titles = ['Sniff', 'Create', 'Den'];

    return Scaffold(
      appBar: AppBar(title: Text(titles[navigationShell.currentIndex])),
      body: Stack(
        children: [
          navigationShell,
          const NapOverlay(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onTap,
        destinations: const [
          NavigationDestination(
            icon: Icon(PhosphorIconsRegular.house),
            selectedIcon: Icon(PhosphorIconsFill.house),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(PhosphorIconsRegular.microphone),
            selectedIcon: Icon(PhosphorIconsFill.microphone),
            label: 'Create',
          ),
          NavigationDestination(
            icon: Icon(PhosphorIconsRegular.pawPrint),
            selectedIcon: Icon(PhosphorIconsFill.pawPrint),
            label: 'Den',
          ),
        ],
      ),
    );
  }
}
