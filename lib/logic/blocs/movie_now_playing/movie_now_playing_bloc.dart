import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/config.dart';
import 'package:movie/data/models/movie.dart';
import 'package:movie/data/repositories/movie_repository.dart';

part 'movie_now_playing_event.dart';
part 'movie_now_playing_state.dart';

class MovieNowPlayingBloc
    extends Bloc<MovieNowPlayingEvent, MovieNowPlayingState> {
  final MovieRepository _movieRepository;

  MovieNowPlayingBloc({required MovieRepository movieRepository})
      : _movieRepository = movieRepository,
        super(MovieNowPlayingInitial()) {
    on<MovieNowPlayingLoaded>(_onMovieNowPlayingLoaded);
  }

  Future<void> _onMovieNowPlayingLoaded(
    MovieNowPlayingLoaded event,
    Emitter<MovieNowPlayingState> emit,
  ) async {
    try {
      emit(MovieNowPlayingLoadInProgress());
      final movies = await _movieRepository.getNowPlaying(
              language: Config.defaultLanguage, page: 1) ??
          [];
      emit(MovieNowPlayingLoadSuccess(movies: movies));
    } catch (e) {
      emit(MovieNowPlayingLoadFailure(error: e));
    }
  }
}
