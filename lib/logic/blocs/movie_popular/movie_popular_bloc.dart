import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/config.dart';
import 'package:movie/data/models/movie.dart';
import 'package:movie/data/repositories/movie_repository.dart';

part 'movie_popular_event.dart';
part 'movie_popular_state.dart';

class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState> {
  final MovieRepository _movieRepository;

  MoviePopularBloc({required MovieRepository movieRepository})
      : _movieRepository = movieRepository,
        super(MoviePopularInitial()) {
    on<MoviePopularLoaded>(_onMoviePopularLoaded);
  }

  Future<void> _onMoviePopularLoaded(
    MoviePopularLoaded event,
    Emitter<MoviePopularState> emit,
  ) async {
    try {
      emit(MoviePopularLoadInProgress());
      final movies = await _movieRepository.getPopular(
              language: Config.defaultLanguage, page: 1) ??
          [];
      emit(MoviePopularLoadSuccess(movies: movies));
    } catch (e) {
      emit(MoviePopularLoadFailure(error: e));
    }
  }
}
