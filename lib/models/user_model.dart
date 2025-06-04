class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final List<int> watchlistMovieIds;

  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.watchlistMovieIds,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String,
      watchlistMovieIds: List<int>.from(json['watchlistMovieIds'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'watchlistMovieIds': watchlistMovieIds,
    };
  }

  UserModel copyWith({
    String? uid,
    String? email,
    String? displayName,
    List<int>? watchlistMovieIds,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      watchlistMovieIds: watchlistMovieIds ?? this.watchlistMovieIds,
    );
  }
}
