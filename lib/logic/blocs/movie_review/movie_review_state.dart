part of 'movie_review_bloc.dart';

abstract class MovieReviewState extends Equatable {
  const MovieReviewState();

  @override
  List<Object?> get props => [];
}

class MovieReviewInitial extends MovieReviewState {}

class MovieReviewLoadInProgress extends MovieReviewState {}

class MovieReviewLoadSuccess extends MovieReviewState {
  final List<Review> reviews;

  const MovieReviewLoadSuccess({
    required this.reviews,
  });

  @override
  List<Object?> get props => [reviews];
}

class MovieReviewLoadFailure extends MovieReviewState {
  final Object error;

  const MovieReviewLoadFailure({
    required this.error,
  });
  @override
  List<Object?> get props => [error];
}
