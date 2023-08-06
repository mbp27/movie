part of 'movie_popular_bloc.dart';

abstract class MoviePopularState extends Equatable {
  const MoviePopularState();

  @override
  List<Object?> get props => [];
}

class MoviePopularInitial extends MoviePopularState {}

class MoviePopularLoadInProgress extends MoviePopularState {}

class MoviePopularLoadSuccess extends MoviePopularState {
  final List<Movie> movies;

  const MoviePopularLoadSuccess({
    required this.movies,
  });

  @override
  List<Object?> get props => [movies];
}

class MoviePopularLoadFailure extends MoviePopularState {
  final Object error;

  const MoviePopularLoadFailure({
    required this.error,
  });
  @override
  List<Object?> get props => [error];
}
