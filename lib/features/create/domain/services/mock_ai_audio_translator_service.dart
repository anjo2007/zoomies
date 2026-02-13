import 'dart:math';

import 'package:zoomies/core/constants/app_constants.dart';

class MockAiAudioTranslatorService {
  String generateCaption({required Duration duration, required double amplitude}) {
    final index = (duration.inMilliseconds + (amplitude * 100).round()) %
        AppConstants.mockAiCaptions.length;
    final caption = AppConstants.mockAiCaptions[index];
    if (Random().nextBool()) {
      return caption;
    }
    return AppConstants.mockAiCaptions[Random().nextInt(AppConstants.mockAiCaptions.length)];
  }
}
