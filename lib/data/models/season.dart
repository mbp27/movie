import 'dart:convert';

class Season {
  final DateTime? airDate;
  final int? episodeCount;
  final int? id;
  final String? name;
  final String? overview;
  final String? posterPath;
  final int? seasonNumber;
  final int? voteAverage;

  Season({
    this.airDate,
    this.episodeCount,
    this.id,
    this.name,
    this.overview,
    this.posterPath,
    this.seasonNumber,
    this.voteAverage,
  });

  Season copyWith({
    DateTime? airDate,
    int? episodeCount,
    int? id,
    String? name,
    String? overview,
    String? posterPath,
    int? seasonNumber,
    int? voteAverage,
  }) {
    return Season(
      airDate: airDate ?? this.airDate,
      episodeCount: episodeCount ?? this.episodeCount,
      id: id ?? this.id,
      name: name ?? this.name,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      seasonNumber: seasonNumber ?? this.seasonNumber,
      voteAverage: voteAverage ?? this.voteAverage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'air_date': airDate?.millisecondsSinceEpoch,
      'episode_count': episodeCount,
      'id': id,
      'name': name,
      'overview': overview,
      'poster_path': posterPath,
      'season_number': seasonNumber,
      'vote_average': voteAverage,
    };
  }

  factory Season.fromMap(Map<String, dynamic> map) {
    return Season(
      airDate: map['air_date'] != null ? DateTime.parse(map['air_date']) : null,
      episodeCount: map['episode_count']?.toInt(),
      id: map['id']?.toInt(),
      name: map['name'],
      overview: map['overview'],
      posterPath: map['poster_path'],
      seasonNumber: map['season_number']?.toInt(),
      voteAverage: map['vote_average']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Season.fromJson(String source) => Season.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Season(airDate: $airDate, episodeCount: $episodeCount, id: $id, name: $name, overview: $overview, posterPath: $posterPath, seasonNumber: $seasonNumber, voteAverage: $voteAverage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Season &&
        other.airDate == airDate &&
        other.episodeCount == episodeCount &&
        other.id == id &&
        other.name == name &&
        other.overview == overview &&
        other.posterPath == posterPath &&
        other.seasonNumber == seasonNumber &&
        other.voteAverage == voteAverage;
  }

  @override
  int get hashCode {
    return airDate.hashCode ^
        episodeCount.hashCode ^
        id.hashCode ^
        name.hashCode ^
        overview.hashCode ^
        posterPath.hashCode ^
        seasonNumber.hashCode ^
        voteAverage.hashCode;
  }
}
