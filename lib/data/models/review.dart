import 'dart:convert';

import 'package:movie/data/models/author_details.dart';

class Review {
  final String? author;
  final AuthorDetails? authorDetails;
  final String? content;
  final DateTime? createdAt;
  final String? id;
  final DateTime? updatedAt;
  final String? url;

  Review({
    this.author,
    this.authorDetails,
    this.content,
    this.createdAt,
    this.id,
    this.updatedAt,
    this.url,
  });

  Review copyWith({
    String? author,
    AuthorDetails? authorDetails,
    String? content,
    DateTime? createdAt,
    String? id,
    DateTime? updatedAt,
    String? url,
  }) {
    return Review(
      author: author ?? this.author,
      authorDetails: authorDetails ?? this.authorDetails,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'author': author,
      'author_details': authorDetails?.toMap(),
      'content': content,
      'created_at': createdAt?.millisecondsSinceEpoch,
      'id': id,
      'updated_at': updatedAt?.millisecondsSinceEpoch,
      'url': url,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      author: map['author'],
      authorDetails: map['author_details'] != null
          ? AuthorDetails.fromMap(map['author_details'])
          : null,
      content: map['content'],
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at']).toLocal()
          : null,
      id: map['id'],
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at']).toLocal()
          : null,
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) => Review.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Review(author: $author, authorDetails: $authorDetails, content: $content, createdAt: $createdAt, id: $id, updatedAt: $updatedAt, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Review &&
        other.author == author &&
        other.authorDetails == authorDetails &&
        other.content == content &&
        other.createdAt == createdAt &&
        other.id == id &&
        other.updatedAt == updatedAt &&
        other.url == url;
  }

  @override
  int get hashCode {
    return author.hashCode ^
        authorDetails.hashCode ^
        content.hashCode ^
        createdAt.hashCode ^
        id.hashCode ^
        updatedAt.hashCode ^
        url.hashCode;
  }
}
