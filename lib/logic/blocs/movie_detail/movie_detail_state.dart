part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object?> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoadInProgress extends MovieDetailState {}

class MovieDetailLoadSuccess extends MovieDetailState {
  final Movie movie;

  const MovieDetailLoadSuccess({
    required this.movie,
  });

  @override
  List<Object?> get props => [movie];
}

class MovieDetailLoadFailure extends MovieDetailState {
  final Object error;

  const MovieDetailLoadFailure({
    required this.error,
  });
  @override
  List<Object?> get props => [error];
}
