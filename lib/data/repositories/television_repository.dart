import 'package:movie/data/models/review.dart';
import 'package:movie/data/models/television.dart';
import 'package:movie/data/providers/television_provider.dart';

class TelevisionRepository {
  final _televisionProvider = TelevisionProvider();

  /// Get on the air television with param [language] and [page]
  Future<List<Television>?> getOnTheAir(
      {required String language, required int page}) async {
    try {
      final data = await _televisionProvider.getOnTheAir(
        language: language,
        page: page,
      );
      final list = data?.map((e) => Television.fromMap(e)).toList();
      return list;
    } catch (e) {
      rethrow;
    }
  }

  /// Get popular television with param [language] and [page]
  Future<List<Television>?> getPopular(
      {required String language, required int page}) async {
    try {
      final data = await _televisionProvider.getPopular(
        language: language,
        page: page,
      );
      final list = data?.map((e) => Television.fromMap(e)).toList();
      return list;
    } catch (e) {
      rethrow;
    }
  }

  /// Get details television with param [language] and [seriesId]
  Future<Television?> getDetails(
      {required String language, required int seriesId}) async {
    try {
      final data = await _televisionProvider.getDetails(
        language: language,
        seriesId: seriesId,
      );
      final object = data != null ? Television.fromMap(data) : null;
      return object;
    } catch (e) {
      rethrow;
    }
  }

  /// Get reviews television with param [language], [page] and [seriesId]
  Future<List<Review>?> getReviews({
    required String language,
    required int page,
    required int seriesId,
  }) async {
    try {
      final data = await _televisionProvider.getReviews(
        language: language,
        page: page,
        seriesId: seriesId,
      );
      final list = data?.map((e) => Review.fromMap(e)).toList();
      return list;
    } catch (e) {
      rethrow;
    }
  }
}
