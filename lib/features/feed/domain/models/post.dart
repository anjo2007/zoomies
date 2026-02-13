class Post {
  const Post({
    required this.id,
    required this.authorId,
    required this.mediaUrl,
    required this.aiCaption,
    required this.audioUrl,
    required this.treatCount,
    required this.timestamp,
  });

  final String id;
  final String authorId;
  final String mediaUrl;
  final String aiCaption;
  final String audioUrl;
  final int treatCount;
  final DateTime timestamp;

  Post copyWith({int? treatCount}) {
    return Post(
      id: id,
      authorId: authorId,
      mediaUrl: mediaUrl,
      aiCaption: aiCaption,
      audioUrl: audioUrl,
      treatCount: treatCount ?? this.treatCount,
      timestamp: timestamp,
    );
  }
}
