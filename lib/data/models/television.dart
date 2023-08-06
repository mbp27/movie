import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:movie/data/models/episode_to_air.dart';
import 'package:movie/data/models/genre.dart';
import 'package:movie/data/models/network.dart';
import 'package:movie/data/models/production_company.dart';
import 'package:movie/data/models/production_country.dart';
import 'package:movie/data/models/season.dart';
import 'package:movie/data/models/spoken_language.dart';

class Television {
  final bool? adult;
  final String? backdropPath;
  final List<int>? episodeRunTime;
  final DateTime? firstAirDate;
  final List<int>? genreIds;
  final List<Genre>? genres;
  final int? id;
  final bool? inProduction;
  final List<String>? languages;
  final DateTime? lastAirDate;
  final EpisodeToAir? lastEpisodeToAir;
  final String? name;
  final EpisodeToAir? nextEpisodeToAir;
  final List<Network>? networks;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<ProductionCompany>? productionCompanies;
  final List<ProductionCountry>? productionCountries;
  final List<Season>? seasons;
  final List<SpokenLanguage>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? type;
  final double? voteAverage;
  final int? voteCount;

  Television({
    this.adult,
    this.backdropPath,
    this.episodeRunTime,
    this.firstAirDate,
    this.genreIds,
    this.genres,
    this.id,
    this.inProduction,
    this.languages,
    this.lastAirDate,
    this.lastEpisodeToAir,
    this.name,
    this.nextEpisodeToAir,
    this.networks,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.seasons,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.type,
    this.voteAverage,
    this.voteCount,
  });

  Television copyWith({
    bool? adult,
    String? backdropPath,
    List<int>? episodeRunTime,
    DateTime? firstAirDate,
    List<int>? genreIds,
    List<Genre>? genres,
    int? id,
    bool? inProduction,
    List<String>? languages,
    DateTime? lastAirDate,
    EpisodeToAir? lastEpisodeToAir,
    String? name,
    EpisodeToAir? nextEpisodeToAir,
    List<Network>? networks,
    int? numberOfEpisodes,
    int? numberOfSeasons,
    List<String>? originCountry,
    String? originalLanguage,
    String? originalName,
    String? overview,
    double? popularity,
    String? posterPath,
    List<ProductionCompany>? productionCompanies,
    List<ProductionCountry>? productionCountries,
    List<Season>? seasons,
    List<SpokenLanguage>? spokenLanguages,
    String? status,
    String? tagline,
    String? type,
    double? voteAverage,
    int? voteCount,
  }) {
    return Television(
      adult: adult ?? this.adult,
      backdropPath: backdropPath ?? this.backdropPath,
      episodeRunTime: episodeRunTime ?? this.episodeRunTime,
      firstAirDate: firstAirDate ?? this.firstAirDate,
      genreIds: genreIds ?? this.genreIds,
      genres: genres ?? this.genres,
      id: id ?? this.id,
      inProduction: inProduction ?? this.inProduction,
      languages: languages ?? this.languages,
      lastAirDate: lastAirDate ?? this.lastAirDate,
      lastEpisodeToAir: lastEpisodeToAir ?? this.lastEpisodeToAir,
      name: name ?? this.name,
      nextEpisodeToAir: nextEpisodeToAir ?? this.nextEpisodeToAir,
      networks: networks ?? this.networks,
      numberOfEpisodes: numberOfEpisodes ?? this.numberOfEpisodes,
      numberOfSeasons: numberOfSeasons ?? this.numberOfSeasons,
      originCountry: originCountry ?? this.originCountry,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalName: originalName ?? this.originalName,
      overview: overview ?? this.overview,
      popularity: popularity ?? this.popularity,
      posterPath: posterPath ?? this.posterPath,
      productionCompanies: productionCompanies ?? this.productionCompanies,
      productionCountries: productionCountries ?? this.productionCountries,
      seasons: seasons ?? this.seasons,
      spokenLanguages: spokenLanguages ?? this.spokenLanguages,
      status: status ?? this.status,
      tagline: tagline ?? this.tagline,
      type: type ?? this.type,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'episode_run_time': episodeRunTime,
      'first_air_date': firstAirDate?.millisecondsSinceEpoch,
      'genre_ids': genreIds,
      'genres': genres?.map((x) => x.toMap()).toList(),
      'id': id,
      'in_production': inProduction,
      'languages': languages,
      'last_air_date': lastAirDate?.millisecondsSinceEpoch,
      'last_episode_to_air': lastEpisodeToAir?.toMap(),
      'name': name,
      'next_episode_to_air': nextEpisodeToAir?.toMap(),
      'networks': networks?.map((x) => x.toMap()).toList(),
      'number_of_episodes': numberOfEpisodes,
      'number_of_seasons': numberOfSeasons,
      'origin_country': originCountry,
      'original_language': originalLanguage,
      'original_name': originalName,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'production_companies':
          productionCompanies?.map((x) => x.toMap()).toList(),
      'production_countries':
          productionCountries?.map((x) => x.toMap()).toList(),
      'seasons': seasons?.map((x) => x.toMap()).toList(),
      'spoken_languages': spokenLanguages?.map((x) => x.toMap()).toList(),
      'status': status,
      'tagline': tagline,
      'type': type,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }

  factory Television.fromMap(Map<String, dynamic> map) {
    return Television(
      adult: map['adult'],
      backdropPath: map['backdrop_path'],
      episodeRunTime: map['episode_run_time'] != null
          ? List<int>.from(map['episode_run_time'])
          : null,
      firstAirDate: map['first_air_date'] != null
          ? DateTime.parse(map['first_air_date'])
          : null,
      genreIds:
          map['genre_ids'] != null ? List<int>.from(map['genre_ids']) : null,
      genres: map['genres'] != null
          ? List<Genre>.from(map['genres']?.map((x) => Genre.fromMap(x)))
          : null,
      id: map['id']?.toInt(),
      inProduction: map['in_production'],
      languages:
          map['languages'] != null ? List<String>.from(map['languages']) : null,
      lastAirDate: map['last_air_date'] != null
          ? DateTime.parse(map['last_air_date'])
          : null,
      lastEpisodeToAir: map['last_episode_to_air'] != null
          ? EpisodeToAir.fromMap(map['last_episode_to_air'])
          : null,
      name: map['name'],
      nextEpisodeToAir: map['next_episode_to_air'] != null
          ? EpisodeToAir.fromMap(map['next_episode_to_air'])
          : null,
      networks: map['networks'] != null
          ? List<Network>.from(map['networks']?.map((x) => Network.fromMap(x)))
          : null,
      numberOfEpisodes: map['number_of_episodes']?.toInt(),
      numberOfSeasons: map['number_of_seasons']?.toInt(),
      originCountry: map['origin_country'] != null
          ? List<String>.from(map['origin_country'])
          : null,
      originalLanguage: map['original_language'],
      originalName: map['original_name'],
      overview: map['overview'],
      popularity: map['popularity']?.toDouble(),
      posterPath: map['poster_path'],
      productionCompanies: map['production_companies'] != null
          ? List<ProductionCompany>.from(map['production_companies']
              ?.map((x) => ProductionCompany.fromMap(x)))
          : null,
      productionCountries: map['production_countries'] != null
          ? List<ProductionCountry>.from(map['production_countries']
              ?.map((x) => ProductionCountry.fromMap(x)))
          : null,
      seasons: map['seasons'] != null
          ? List<Season>.from(map['seasons']?.map((x) => Season.fromMap(x)))
          : null,
      spokenLanguages: map['spoken_languages'] != null
          ? List<SpokenLanguage>.from(
              map['spoken_languages']?.map((x) => SpokenLanguage.fromMap(x)))
          : null,
      status: map['status'],
      tagline: map['tagline'],
      type: map['type'],
      voteAverage: map['vote_average']?.toDouble(),
      voteCount: map['vote_count']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Television.fromJson(String source) =>
      Television.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Television(adult: $adult, backdropPath: $backdropPath, episodeRunTime: $episodeRunTime, firstAirDate: $firstAirDate, genreIds: $genreIds, genres: $genres, id: $id, inProduction: $inProduction, languages: $languages, lastAirDate: $lastAirDate, lastEpisodeToAir: $lastEpisodeToAir, name: $name, nextEpisodeToAir: $nextEpisodeToAir, networks: $networks, numberOfEpisodes: $numberOfEpisodes, numberOfSeasons: $numberOfSeasons, originCountry: $originCountry, originalLanguage: $originalLanguage, originalName: $originalName, overview: $overview, popularity: $popularity, posterPath: $posterPath, productionCompanies: $productionCompanies, productionCountries: $productionCountries, seasons: $seasons, spokenLanguages: $spokenLanguages, status: $status, tagline: $tagline, type: $type, voteAverage: $voteAverage, voteCount: $voteCount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Television &&
        other.adult == adult &&
        other.backdropPath == backdropPath &&
        listEquals(other.episodeRunTime, episodeRunTime) &&
        other.firstAirDate == firstAirDate &&
        listEquals(other.genreIds, genreIds) &&
        listEquals(other.genres, genres) &&
        other.id == id &&
        other.inProduction == inProduction &&
        listEquals(other.languages, languages) &&
        other.lastAirDate == lastAirDate &&
        other.lastEpisodeToAir == lastEpisodeToAir &&
        other.name == name &&
        other.nextEpisodeToAir == nextEpisodeToAir &&
        listEquals(other.networks, networks) &&
        other.numberOfEpisodes == numberOfEpisodes &&
        other.numberOfSeasons == numberOfSeasons &&
        listEquals(other.originCountry, originCountry) &&
        other.originalLanguage == originalLanguage &&
        other.originalName == originalName &&
        other.overview == overview &&
        other.popularity == popularity &&
        other.posterPath == posterPath &&
        listEquals(other.productionCompanies, productionCompanies) &&
        listEquals(other.productionCountries, productionCountries) &&
        listEquals(other.seasons, seasons) &&
        listEquals(other.spokenLanguages, spokenLanguages) &&
        other.status == status &&
        other.tagline == tagline &&
        other.type == type &&
        other.voteAverage == voteAverage &&
        other.voteCount == voteCount;
  }

  @override
  int get hashCode {
    return adult.hashCode ^
        backdropPath.hashCode ^
        episodeRunTime.hashCode ^
        firstAirDate.hashCode ^
        genreIds.hashCode ^
        genres.hashCode ^
        id.hashCode ^
        inProduction.hashCode ^
        languages.hashCode ^
        lastAirDate.hashCode ^
        lastEpisodeToAir.hashCode ^
        name.hashCode ^
        nextEpisodeToAir.hashCode ^
        networks.hashCode ^
        numberOfEpisodes.hashCode ^
        numberOfSeasons.hashCode ^
        originCountry.hashCode ^
        originalLanguage.hashCode ^
        originalName.hashCode ^
        overview.hashCode ^
        popularity.hashCode ^
        posterPath.hashCode ^
        productionCompanies.hashCode ^
        productionCountries.hashCode ^
        seasons.hashCode ^
        spokenLanguages.hashCode ^
        status.hashCode ^
        tagline.hashCode ^
        type.hashCode ^
        voteAverage.hashCode ^
        voteCount.hashCode;
  }
}
