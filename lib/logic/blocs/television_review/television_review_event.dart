part of 'television_review_bloc.dart';

abstract class TelevisionReviewEvent extends Equatable {
  const TelevisionReviewEvent();

  @override
  List<Object?> get props => [];
}

class TelevisionReviewLoaded extends TelevisionReviewEvent {
  final Television television;

  const TelevisionReviewLoaded({
    required this.television,
  });

  @override
  List<Object?> get props => [television];
}
