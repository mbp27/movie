part of 'movie_upcoming_bloc.dart';

class MovieUpcomingState extends Equatable {
  const MovieUpcomingState();

  @override
  List<Object?> get props => [];
}

class MovieUpcomingInitial extends MovieUpcomingState {}

class MovieUpcomingLoadInProgress extends MovieUpcomingState {}

class MovieUpcomingLoadSuccess extends MovieUpcomingState {
  final List<Movie> movies;

  const MovieUpcomingLoadSuccess({
    required this.movies,
  });

  @override
  List<Object?> get props => [movies];
}

class MovieUpcomingLoadFailure extends MovieUpcomingState {
  final Object error;

  const MovieUpcomingLoadFailure({
    required this.error,
  });
  @override
  List<Object?> get props => [error];
}
