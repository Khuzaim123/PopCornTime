import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class WatchlistService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'users';

  // Get user's watchlist
  Future<List<int>> getWatchlist(String userId) async {
    try {
      final doc = await _firestore.collection(_collection).doc(userId).get();
      if (!doc.exists) return [];
      final data = doc.data() as Map<String, dynamic>;
      return List<int>.from(data['watchlistMovieIds'] ?? []);
    } catch (e) {
      rethrow;
    }
  }

  // Add movie to watchlist
  Future<void> addToWatchlist(String userId, int movieId) async {
    try {
      final doc = await _firestore.collection(_collection).doc(userId).get();
      if (!doc.exists) {
        await _firestore.collection(_collection).doc(userId).set({
          'watchlistMovieIds': [movieId],
        });
      } else {
        final data = doc.data() as Map<String, dynamic>;
        final watchlist = List<int>.from(data['watchlistMovieIds'] ?? []);
        if (!watchlist.contains(movieId)) {
          watchlist.add(movieId);
          await _firestore.collection(_collection).doc(userId).update({
            'watchlistMovieIds': watchlist,
          });
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  // Remove movie from watchlist
  Future<void> removeFromWatchlist(String userId, int movieId) async {
    try {
      final doc = await _firestore.collection(_collection).doc(userId).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        final watchlist = List<int>.from(data['watchlistMovieIds'] ?? []);
        watchlist.remove(movieId);
        await _firestore.collection(_collection).doc(userId).update({
          'watchlistMovieIds': watchlist,
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  // Check if movie is in watchlist
  Future<bool> isInWatchlist(String userId, int movieId) async {
    try {
      final watchlist = await getWatchlist(userId);
      return watchlist.contains(movieId);
    } catch (e) {
      rethrow;
    }
  }

  // Stream of watchlist changes
  Stream<List<int>> watchWatchlist(String userId) {
    return _firestore.collection(_collection).doc(userId).snapshots().map((
      doc,
    ) {
      if (!doc.exists) return [];
      final data = doc.data() as Map<String, dynamic>;
      return List<int>.from(data['watchlistMovieIds'] ?? []);
    });
  }
}
