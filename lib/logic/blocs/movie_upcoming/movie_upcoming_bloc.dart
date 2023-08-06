import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/config.dart';
import 'package:movie/data/models/movie.dart';
import 'package:movie/data/repositories/movie_repository.dart';

part 'movie_upcoming_event.dart';
part 'movie_upcoming_state.dart';

class MovieUpcomingBloc extends Bloc<MovieUpcomingEvent, MovieUpcomingState> {
  final MovieRepository _movieRepository;

  MovieUpcomingBloc({required MovieRepository movieRepository})
      : _movieRepository = movieRepository,
        super(MovieUpcomingInitial()) {
    on<MovieUpcomingLoaded>(_onMovieUpcomingLoaded);
  }

  Future<void> _onMovieUpcomingLoaded(
    MovieUpcomingLoaded event,
    Emitter<MovieUpcomingState> emit,
  ) async {
    try {
      emit(MovieUpcomingLoadInProgress());
      final movies = await _movieRepository.getUpcoming(
              language: Config.defaultLanguage, page: 1) ??
          [];
      emit(MovieUpcomingLoadSuccess(movies: movies));
    } catch (e) {
      emit(MovieUpcomingLoadFailure(error: e));
    }
  }
}
