import 'dart:convert';

class EpisodeToAir {
  final int? id;
  final String? name;
  final String? overview;
  final int? voteAverage;
  final int? voteCount;
  final DateTime? airDate;
  final int? episodeNumber;
  final String? productionCode;
  final int? runtime;
  final int? seasonNumber;
  final int? showId;
  final String? stillPath;

  EpisodeToAir({
    this.id,
    this.name,
    this.overview,
    this.voteAverage,
    this.voteCount,
    this.airDate,
    this.episodeNumber,
    this.productionCode,
    this.runtime,
    this.seasonNumber,
    this.showId,
    this.stillPath,
  });

  EpisodeToAir copyWith({
    int? id,
    String? name,
    String? overview,
    int? voteAverage,
    int? voteCount,
    DateTime? airDate,
    int? episodeNumber,
    String? productionCode,
    int? runtime,
    int? seasonNumber,
    int? showId,
    String? stillPath,
  }) {
    return EpisodeToAir(
      id: id ?? this.id,
      name: name ?? this.name,
      overview: overview ?? this.overview,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      airDate: airDate ?? this.airDate,
      episodeNumber: episodeNumber ?? this.episodeNumber,
      productionCode: productionCode ?? this.productionCode,
      runtime: runtime ?? this.runtime,
      seasonNumber: seasonNumber ?? this.seasonNumber,
      showId: showId ?? this.showId,
      stillPath: stillPath ?? this.stillPath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'overview': overview,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'air_date': airDate?.millisecondsSinceEpoch,
      'episode_number': episodeNumber,
      'production_code': productionCode,
      'runtime': runtime,
      'season_number': seasonNumber,
      'show_id': showId,
      'still_path': stillPath,
    };
  }

  factory EpisodeToAir.fromMap(Map<String, dynamic> map) {
    return EpisodeToAir(
      id: map['id']?.toInt(),
      name: map['name'],
      overview: map['overview'],
      voteAverage: map['vote_average']?.toInt(),
      voteCount: map['vote_count']?.toInt(),
      airDate: map['air_date'] != null ? DateTime.parse(map['air_date']) : null,
      episodeNumber: map['episode_number']?.toInt(),
      productionCode: map['production_code'],
      runtime: map['runtime']?.toInt(),
      seasonNumber: map['season_number']?.toInt(),
      showId: map['show_id']?.toInt(),
      stillPath: map['still_path'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EpisodeToAir.fromJson(String source) =>
      EpisodeToAir.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EpisodeToAir(id: $id, name: $name, overview: $overview, voteAverage: $voteAverage, voteCount: $voteCount, airDate: $airDate, episodeNumber: $episodeNumber, productionCode: $productionCode, runtime: $runtime, seasonNumber: $seasonNumber, showId: $showId, stillPath: $stillPath)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EpisodeToAir &&
        other.id == id &&
        other.name == name &&
        other.overview == overview &&
        other.voteAverage == voteAverage &&
        other.voteCount == voteCount &&
        other.airDate == airDate &&
        other.episodeNumber == episodeNumber &&
        other.productionCode == productionCode &&
        other.runtime == runtime &&
        other.seasonNumber == seasonNumber &&
        other.showId == showId &&
        other.stillPath == stillPath;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        overview.hashCode ^
        voteAverage.hashCode ^
        voteCount.hashCode ^
        airDate.hashCode ^
        episodeNumber.hashCode ^
        productionCode.hashCode ^
        runtime.hashCode ^
        seasonNumber.hashCode ^
        showId.hashCode ^
        stillPath.hashCode;
  }
}
