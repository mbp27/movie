part of 'movie_review_bloc.dart';

abstract class MovieReviewEvent extends Equatable {
  const MovieReviewEvent();

  @override
  List<Object?> get props => [];
}

class MovieReviewLoaded extends MovieReviewEvent {
  final Movie movie;

  const MovieReviewLoaded({
    required this.movie,
  });

  @override
  List<Object?> get props => [movie];
}
