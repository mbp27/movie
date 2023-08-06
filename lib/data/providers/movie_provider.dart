import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:movie/data/http/movie_http.dart';

class MovieProvider {
  final _movieHttp = MovieHttp();

  /// Get now playing movie with param [language] and [page]
  Future<List?> getNowPlaying(
      {required String language, required int page}) async {
    try {
      final response = await _movieHttp.getNowPlaying(
        language: language,
        page: page,
      );
      final body = json.decode(response.body) as Map;
      if (response.statusCode == 200) {
        return body['results'];
      } else if (response.statusCode == 404) {
        throw body['status_message'];
      } else {
        throw '${response.statusCode} : ${response.reasonPhrase}';
      }
    } catch (e) {
      if (e is SocketException || e is ClientException) {
        throw 'Check internet connection';
      } else {
        rethrow;
      }
    }
  }

  /// Get upcoming movie with param [language] and [page]
  Future<List?> getUpcoming(
      {required String language, required int page}) async {
    try {
      final response = await _movieHttp.getUpcoming(
        language: language,
        page: page,
      );
      final body = json.decode(response.body) as Map;
      if (response.statusCode == 200) {
        return body['results'];
      } else if (response.statusCode == 404) {
        throw body['status_message'];
      } else {
        throw '${response.statusCode} : ${response.reasonPhrase}';
      }
    } catch (e) {
      if (e is SocketException || e is ClientException) {
        throw 'Check internet connection';
      } else {
        rethrow;
      }
    }
  }

  /// Get popular movie with param [language] and [page]
  Future<List?> getPopular(
      {required String language, required int page}) async {
    try {
      final response = await _movieHttp.getPopular(
        language: language,
        page: page,
      );
      final body = json.decode(response.body) as Map;
      if (response.statusCode == 200) {
        return body['results'];
      } else if (response.statusCode == 404) {
        throw body['status_message'];
      } else {
        throw '${response.statusCode} : ${response.reasonPhrase}';
      }
    } catch (e) {
      if (e is SocketException || e is ClientException) {
        throw 'Check internet connection';
      } else {
        rethrow;
      }
    }
  }

  /// Get details movie with param [language] and [movieId]
  Future<Map<String, dynamic>?> getDetails(
      {required String language, required int movieId}) async {
    try {
      final response = await _movieHttp.getDetails(
        language: language,
        movieId: movieId,
      );
      final body = json.decode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        return body;
      } else if (response.statusCode == 404) {
        throw body['status_message'];
      } else {
        throw '${response.statusCode} : ${response.reasonPhrase}';
      }
    } catch (e) {
      if (e is SocketException || e is ClientException) {
        throw 'Check internet connection';
      } else {
        rethrow;
      }
    }
  }

  /// Get reviews movie with param [language], [page] and [movieId]
  Future<List?> getReviews({
    required String language,
    required int page,
    required int movieId,
  }) async {
    try {
      final response = await _movieHttp.getReviews(
        language: language,
        page: page,
        movieId: movieId,
      );
      final body = json.decode(response.body) as Map;
      if (response.statusCode == 200) {
        return body['results'];
      } else if (response.statusCode == 404) {
        throw body['status_message'];
      } else {
        throw '${response.statusCode} : ${response.reasonPhrase}';
      }
    } catch (e) {
      if (e is SocketException || e is ClientException) {
        throw 'Check internet connection';
      } else {
        rethrow;
      }
    }
  }
}
