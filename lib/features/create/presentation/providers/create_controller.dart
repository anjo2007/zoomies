import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoomies/features/create/domain/services/mock_ai_audio_translator_service.dart';

class CreateState {
  const CreateState({
    this.isRecording = false,
    this.currentDuration = Duration.zero,
    this.generatedCaption,
  });

  final bool isRecording;
  final Duration currentDuration;
  final String? generatedCaption;

  CreateState copyWith({bool? isRecording, Duration? currentDuration, String? generatedCaption}) {
    return CreateState(
      isRecording: isRecording ?? this.isRecording,
      currentDuration: currentDuration ?? this.currentDuration,
      generatedCaption: generatedCaption ?? this.generatedCaption,
    );
  }
}

final mockAiServiceProvider = Provider<MockAiAudioTranslatorService>((ref) {
  return MockAiAudioTranslatorService();
});

class CreateController extends StateNotifier<CreateState> {
  CreateController(this._ref) : super(const CreateState());

  final Ref _ref;
  Timer? _timer;

  void toggleRecording() {
    if (state.isRecording) {
      _timer?.cancel();
      final aiService = _ref.read(mockAiServiceProvider);
      final caption = aiService.generateCaption(
        duration: state.currentDuration,
        amplitude: 0.7,
      );
      state = state.copyWith(isRecording: false, generatedCaption: caption);
      return;
    }

    state = const CreateState(isRecording: true, currentDuration: Duration.zero);
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      state = state.copyWith(currentDuration: state.currentDuration + const Duration(seconds: 1));
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final createControllerProvider = StateNotifierProvider<CreateController, CreateState>((ref) {
  return CreateController(ref);
});
