import 'package:http/http.dart' as http;
import 'package:movie/config.dart';

class MovieHttp {
  static final String _baseUrl = Config.baseUrl;
  static final String _version = Config.versionApi;
  static final String _path = '$_version/movie';
  static final String _apiKey = Config.apiKey;

  /// Get now playing movie with param [language] and [page]
  Future<http.Response> getNowPlaying({
    required String language,
    required int page,
  }) {
    Map<String, dynamic> queryParameters = {
      "api_key": _apiKey,
      "language": language,
      "page": page.toString(),
    };

    return http.get(
      Uri.https(_baseUrl, '$_path/now_playing', queryParameters),
    );
  }

  /// Get upcoming movie with param [language] and [page]
  Future<http.Response> getUpcoming({
    required String language,
    required int page,
  }) {
    Map<String, dynamic> queryParameters = {
      "api_key": _apiKey,
      "language": language,
      "page": page.toString(),
    };

    return http.get(
      Uri.https(_baseUrl, '$_path/upcoming', queryParameters),
    );
  }

  /// Get popular movie with param [language] and [page]
  Future<http.Response> getPopular({
    required String language,
    required int page,
  }) {
    Map<String, dynamic> queryParameters = {
      "api_key": _apiKey,
      "language": language,
      "page": page.toString(),
    };

    return http.get(
      Uri.https(_baseUrl, '$_path/popular', queryParameters),
    );
  }

  /// Get details movie with param [language] and [movieId]
  Future<http.Response> getDetails({
    required String language,
    required int movieId,
  }) {
    Map<String, dynamic> queryParameters = {
      "api_key": _apiKey,
      "language": language,
    };

    return http.get(
      Uri.https(_baseUrl, '$_path/$movieId', queryParameters),
    );
  }

  /// Get reviews movie with param [language], [page] and [movieId]
  Future<http.Response> getReviews({
    required String language,
    required int page,
    required int movieId,
  }) {
    Map<String, dynamic> queryParameters = {
      "api_key": _apiKey,
      "language": language,
      "page": page.toString(),
    };

    return http.get(
      Uri.https(_baseUrl, '$_path/$movieId/reviews', queryParameters),
    );
  }
}
