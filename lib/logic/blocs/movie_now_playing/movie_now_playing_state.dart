part of 'movie_now_playing_bloc.dart';

class MovieNowPlayingState extends Equatable {
  const MovieNowPlayingState();

  @override
  List<Object?> get props => [];
}

class MovieNowPlayingInitial extends MovieNowPlayingState {}

class MovieNowPlayingLoadInProgress extends MovieNowPlayingState {}

class MovieNowPlayingLoadSuccess extends MovieNowPlayingState {
  final List<Movie> movies;

  const MovieNowPlayingLoadSuccess({
    required this.movies,
  });

  @override
  List<Object?> get props => [movies];
}

class MovieNowPlayingLoadFailure extends MovieNowPlayingState {
  final Object error;

  const MovieNowPlayingLoadFailure({
    required this.error,
  });
  @override
  List<Object?> get props => [error];
}
