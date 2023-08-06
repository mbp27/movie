import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:movie/data/http/television_http.dart';

class TelevisionProvider {
  final _televisionHttp = TelevisionHttp();

  /// Get now playing television with param [language] and [page]
  Future<List?> getOnTheAir(
      {required String language, required int page}) async {
    try {
      final response = await _televisionHttp.getOnTheAir(
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

  /// Get popular television with param [language] and [page]
  Future<List?> getPopular(
      {required String language, required int page}) async {
    try {
      final response = await _televisionHttp.getPopular(
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

  /// Get details television with param [language] and [seriesId]
  Future<Map<String, dynamic>?> getDetails(
      {required String language, required int seriesId}) async {
    try {
      final response = await _televisionHttp.getDetails(
        language: language,
        seriesId: seriesId,
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

  /// Get reviews television with param [language], [page] and [seriesId]
  Future<List?> getReviews({
    required String language,
    required int page,
    required int seriesId,
  }) async {
    try {
      final response = await _televisionHttp.getReviews(
        language: language,
        page: page,
        seriesId: seriesId,
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
