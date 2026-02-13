class AppConstants {
  AppConstants._();

  static const int napPostsThreshold = 50;
  static const Duration napSessionThreshold = Duration(minutes: 20);
  static const Duration napLockDuration = Duration(seconds: 10);

  static const List<String> tribes = ['shadow', 'dreamer', 'healer'];

  static const List<String> mockAiCaptions = [
    'The cheese tax must be paid.',
    'I see ghosts behind the fridge.',
    'No thoughts, just zoomies.',
    'I barked at the wind and won.',
    'I was told there would be snacks.',
  ];
}
