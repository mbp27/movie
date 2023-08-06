import 'package:movie/data/models/movie.dart';
import 'package:movie/data/models/review.dart';
import 'package:movie/data/providers/movie_provider.dart';

class MovieRepository {
  final _movieProvider = MovieProvider();

  /// Get now playing movie with param [language] and [page]
  Future<List<Movie>?> getNowPlaying(
      {required String language, required int page}) async {
    try {
      final data = await _movieProvider.getNowPlaying(
        language: language,
        page: page,
      );
      final list = data?.map((e) => Movie.fromMap(e)).toList();
      return list;
    } catch (e) {
      rethrow;
    }
  }

  /// Get upcoming movie with param [language] and [page]
  Future<List<Movie>?> getUpcoming(
      {required String language, required int page}) async {
    try {
      final data = await _movieProvider.getUpcoming(
        language: language,
        page: page,
      );
      final list = data?.map((e) => Movie.fromMap(e)).toList();
      return list;
    } catch (e) {
      rethrow;
    }
  }

  /// Get popular movie with param [language] and [page]
  Future<List<Movie>?> getPopular(
      {required String language, required int page}) async {
    try {
      final data = await _movieProvider.getPopular(
        language: language,
        page: page,
      );
      final list = data?.map((e) => Movie.fromMap(e)).toList();
      return list;
    } catch (e) {
      rethrow;
    }
  }

  /// Get details movie with param [language] and [movieId]
  Future<Movie?> getDetails(
      {required String language, required int movieId}) async {
    try {
      final data = await _movieProvider.getDetails(
        language: language,
        movieId: movieId,
      );
      final object = data != null ? Movie.fromMap(data) : null;
      return object;
    } catch (e) {
      rethrow;
    }
  }

  /// Get reviews movie with param [language], [page] and [movieId]
  Future<List<Review>?> getReviews({
    required String language,
    required int page,
    required int movieId,
  }) async {
    try {
      final data = await _movieProvider.getReviews(
        language: language,
        page: page,
        movieId: movieId,
      );
      final list = data?.map((e) => Review.fromMap(e)).toList();
      return list;
    } catch (e) {
      rethrow;
    }
  }
}
