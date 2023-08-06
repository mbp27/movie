import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/config.dart';
import 'package:movie/data/models/movie.dart';
import 'package:movie/data/repositories/movie_repository.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final MovieRepository _movieRepository;

  MovieDetailBloc({required MovieRepository movieRepository})
      : _movieRepository = movieRepository,
        super(MovieDetailInitial()) {
    on<MovieDetailLoaded>(_onMovieDetailLoaded);
  }

  Future<void> _onMovieDetailLoaded(
    MovieDetailLoaded event,
    Emitter<MovieDetailState> emit,
  ) async {
    try {
      emit(MovieDetailLoadInProgress());
      final movieId = event.movie.id;
      if (movieId == null) throw 'An error occurred.';
      final movie = await _movieRepository.getDetails(
          language: Config.defaultLanguage, movieId: movieId);
      if (movie == null) throw 'No data found.';
      emit(MovieDetailLoadSuccess(movie: movie));
    } catch (e) {
      emit(MovieDetailLoadFailure(error: e));
    }
  }
}
