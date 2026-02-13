import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoomies/features/den/domain/models/pet.dart';

class DenController extends StateNotifier<Pet> {
  DenController()
      : super(
          Pet(
            name: 'Barnaby',
            energyLevel: 1,
            lastNapTime: DateTime.now(),
            decor: const {'hat': 'none', 'rug': 'default'},
            social: 20,
            kibble: 100,
          ),
        ) {
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      state = state.copyWith(energyLevel: (state.energyLevel - 0.01).clamp(0.0, 1.0));
    });
  }

  late final Timer _timer;

  void gainSocial() {
    state = state.copyWith(social: state.social + 1, kibble: state.kibble + 2);
  }

  void buyRug() {
    if (state.kibble < 50) {
      return;
    }
    state = state.copyWith(kibble: state.kibble - 50, decor: {...state.decor, 'rug': 'terra_rug'});
  }

  void buyHat() {
    if (state.kibble < 30) {
      return;
    }
    state = state.copyWith(kibble: state.kibble - 30, decor: {...state.decor, 'hat': 'party_hat'});
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

final denControllerProvider = StateNotifierProvider<DenController, Pet>((ref) {
  return DenController();
});
