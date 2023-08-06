import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/config.dart';
import 'package:movie/data/models/movie.dart';
import 'package:movie/data/models/review.dart';
import 'package:movie/data/repositories/movie_repository.dart';

part 'movie_review_event.dart';
part 'movie_review_state.dart';

class MovieReviewBloc extends Bloc<MovieReviewEvent, MovieReviewState> {
  final MovieRepository _movieRepository;

  MovieReviewBloc({required MovieRepository movieRepository})
      : _movieRepository = movieRepository,
        super(MovieReviewInitial()) {
    on<MovieReviewLoaded>(_onMovieReviewLoaded);
  }

  Future<void> _onMovieReviewLoaded(
    MovieReviewLoaded event,
    Emitter<MovieReviewState> emit,
  ) async {
    try {
      emit(MovieReviewLoadInProgress());
      final movieId = event.movie.id;
      if (movieId == null) throw 'An error occurred.';
      final reviews = await _movieRepository.getReviews(
              language: Config.defaultLanguage, page: 1, movieId: movieId) ??
          [];
      emit(MovieReviewLoadSuccess(reviews: reviews));
    } catch (e) {
      emit(MovieReviewLoadFailure(error: e));
    }
  }
}
