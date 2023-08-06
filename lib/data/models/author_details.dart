import 'dart:convert';

class AuthorDetails {
  final String? name;
  final String? username;
  final String? avatarPath;
  final int? rating;

  AuthorDetails({
    this.name,
    this.username,
    this.avatarPath,
    this.rating,
  });

  AuthorDetails copyWith({
    String? name,
    String? username,
    String? avatarPath,
    int? rating,
  }) {
    return AuthorDetails(
      name: name ?? this.name,
      username: username ?? this.username,
      avatarPath: avatarPath ?? this.avatarPath,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'avatar_path': avatarPath,
      'rating': rating,
    };
  }

  factory AuthorDetails.fromMap(Map<String, dynamic> map) {
    return AuthorDetails(
      name: map['name'],
      username: map['username'],
      avatarPath: map['avatar_path'],
      rating: map['rating']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthorDetails.fromJson(String source) =>
      AuthorDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AuthorDetails(name: $name, username: $username, avatarPath: $avatarPath, rating: $rating)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthorDetails &&
        other.name == name &&
        other.username == username &&
        other.avatarPath == avatarPath &&
        other.rating == rating;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        username.hashCode ^
        avatarPath.hashCode ^
        rating.hashCode;
  }
}
