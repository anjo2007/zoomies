import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoomies/core/constants/app_constants.dart';

class SessionState {
  const SessionState({
    required this.sessionDuration,
    required this.postsScrolled,
    required this.napUntil,
  });

  final Duration sessionDuration;
  final int postsScrolled;
  final DateTime? napUntil;

  bool get shouldNap {
    if (napUntil != null && DateTime.now().isBefore(napUntil!)) {
      return true;
    }
    return sessionDuration >= AppConstants.napSessionThreshold ||
        postsScrolled >= AppConstants.napPostsThreshold;
  }

  SessionState copyWith({Duration? sessionDuration, int? postsScrolled, DateTime? napUntil}) {
    return SessionState(
      sessionDuration: sessionDuration ?? this.sessionDuration,
      postsScrolled: postsScrolled ?? this.postsScrolled,
      napUntil: napUntil,
    );
  }
}

class SessionStateController extends StateNotifier<SessionState> {
  SessionStateController()
      : super(const SessionState(sessionDuration: Duration.zero, postsScrolled: 0, napUntil: null)) {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      state = state.copyWith(sessionDuration: state.sessionDuration + const Duration(seconds: 1));
      if (state.shouldNap && state.napUntil == null) {
        state = state.copyWith(napUntil: DateTime.now().add(AppConstants.napLockDuration));
      }
    });
  }

  late final Timer _timer;

  void registerScroll() {
    state = state.copyWith(postsScrolled: state.postsScrolled + 1);
    if (state.shouldNap && state.napUntil == null) {
      state = state.copyWith(napUntil: DateTime.now().add(AppConstants.napLockDuration));
    }
  }

  void acknowledgeNap() {
    if (state.napUntil != null && DateTime.now().isAfter(state.napUntil!)) {
      state = const SessionState(sessionDuration: Duration.zero, postsScrolled: 0, napUntil: null);
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

final sessionStateProvider = StateNotifierProvider<SessionStateController, SessionState>((ref) {
  return SessionStateController();
});
