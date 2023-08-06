part of 'television_review_bloc.dart';

abstract class TelevisionReviewState extends Equatable {
  const TelevisionReviewState();

  @override
  List<Object?> get props => [];
}

class TelevisionReviewInitial extends TelevisionReviewState {}

class TelevisionReviewLoadInProgress extends TelevisionReviewState {}

class TelevisionReviewLoadSuccess extends TelevisionReviewState {
  final List<Review> reviews;

  const TelevisionReviewLoadSuccess({
    required this.reviews,
  });

  @override
  List<Object?> get props => [reviews];
}

class TelevisionReviewLoadFailure extends TelevisionReviewState {
  final Object error;

  const TelevisionReviewLoadFailure({
    required this.error,
  });
  @override
  List<Object?> get props => [error];
}
