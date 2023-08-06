import 'package:http/http.dart' as http;
import 'package:movie/config.dart';

class TelevisionHttp {
  static final String _baseUrl = Config.baseUrl;
  static final String _version = Config.versionApi;
  static final String _path = '$_version/tv';
  static final String _apiKey = Config.apiKey;

  /// Get on the air television with param [language] and [page]
  Future<http.Response> getOnTheAir({
    required String language,
    required int page,
  }) {
    Map<String, dynamic> queryParameters = {
      "api_key": _apiKey,
      "language": language,
      "page": page.toString(),
    };

    return http.get(
      Uri.https(_baseUrl, '$_path/on_the_air', queryParameters),
    );
  }

  /// Get popular television with param [language] and [page]
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

  /// Get details television with param [language] and [seriesId]
  Future<http.Response> getDetails({
    required String language,
    required int seriesId,
  }) {
    Map<String, dynamic> queryParameters = {
      "api_key": _apiKey,
      "language": language,
    };

    return http.get(
      Uri.https(_baseUrl, '$_path/$seriesId', queryParameters),
    );
  }

  /// Get reviews television with param [language], [page] and [seriesId]
  Future<http.Response> getReviews({
    required String language,
    required int page,
    required int seriesId,
  }) {
    Map<String, dynamic> queryParameters = {
      "api_key": _apiKey,
      "language": language,
      "page": page.toString(),
    };

    return http.get(
      Uri.https(_baseUrl, '$_path/$seriesId/reviews', queryParameters),
    );
  }
}
