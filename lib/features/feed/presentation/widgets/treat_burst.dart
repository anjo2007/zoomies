import 'dart:math' as math;

import 'package:flutter/material.dart';

class TreatBurst extends StatefulWidget {
  const TreatBurst({super.key});

  @override
  State<TreatBurst> createState() => _TreatBurstState();
}

class _TreatBurstState extends State<TreatBurst> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 450),
  )..forward();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = Curves.easeOut.transform(_controller.value);
        return Stack(
          alignment: Alignment.center,
          children: List.generate(8, (i) {
            final angle = (i / 8) * 2 * math.pi;
            final dx = 36 * t * math.cos(angle);
            final dy = 36 * t * math.sin(angle);
            return Transform.translate(
              offset: Offset(dx, dy),
              child: Opacity(
                opacity: 1 - t,
                child: const Text('🦴', style: TextStyle(fontSize: 16)),
              ),
            );
          }),
        );
      },
    );
  }
}
