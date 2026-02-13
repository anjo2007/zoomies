import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zoomies/features/feed/domain/models/post.dart';
import 'package:zoomies/features/feed/domain/repositories/post_repository.dart';

class FirebasePostRepository implements PostRepository {
  FirebasePostRepository(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Future<List<Post>> fetchPosts({String? lastPostId, int limit = 10}) async {
    Query<Map<String, dynamic>> query = _firestore
        .collection('posts')
        .orderBy('timestamp', descending: true)
        .limit(limit);

    if (lastPostId != null) {
      final lastDoc = await _firestore.collection('posts').doc(lastPostId).get();
      if (lastDoc.exists) {
        query = query.startAfterDocument(lastDoc);
      }
    }

    final snapshot = await query.get();
    return snapshot.docs
        .map(
          (doc) => Post(
            id: doc.id,
            authorId: doc.data()['authorId'] as String? ?? '',
            mediaUrl: doc.data()['mediaUrl'] as String? ?? '',
            aiCaption: doc.data()['aiCaption'] as String? ?? '',
            audioUrl: doc.data()['audioUrl'] as String? ?? '',
            treatCount: doc.data()['treatCount'] as int? ?? 0,
            timestamp: (doc.data()['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
          ),
        )
        .toList(growable: false);
  }

  @override
  Future<void> incrementTreat(String postId) async {
    await _firestore.collection('posts').doc(postId).update({
      'treatCount': FieldValue.increment(1),
    });
  }
}
