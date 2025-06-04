class UserModel {
  final String uid;
  final String email;
  final String? displayName;
  final String? photoURL;
  final List<int> watchlistMovieIds;
  final DateTime createdAt;
  final DateTime lastLoginAt;
  final String? phoneNumber;
  final bool isVerified;

  const UserModel({
    required this.uid,
    required this.email,
    this.displayName,
    this.photoURL,
    this.watchlistMovieIds = const [],
    required this.createdAt,
    required this.lastLoginAt,
    this.phoneNumber,
    this.isVerified = true,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String?,
      photoURL: json['photoURL'] as String?,
      watchlistMovieIds: List<int>.from(
        json['watchlistMovieIds'] as List? ?? [],
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastLoginAt: DateTime.parse(json['lastLoginAt'] as String),
      phoneNumber: json['phoneNumber'] as String?,
      isVerified: json['isVerified'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
      'watchlistMovieIds': watchlistMovieIds,
      'createdAt': createdAt.toIso8601String(),
      'lastLoginAt': lastLoginAt.toIso8601String(),
      'phoneNumber': phoneNumber,
      'isVerified': isVerified,
    };
  }

  UserModel copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? photoURL,
    List<int>? watchlistMovieIds,
    DateTime? createdAt,
    DateTime? lastLoginAt,
    String? phoneNumber,
    bool? isVerified,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoURL: photoURL ?? this.photoURL,
      watchlistMovieIds: watchlistMovieIds ?? this.watchlistMovieIds,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  bool isMovieInWatchlist(int movieId) => watchlistMovieIds.contains(movieId);
}
