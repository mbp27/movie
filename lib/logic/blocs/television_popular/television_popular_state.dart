part of 'television_popular_bloc.dart';

class TelevisionPopularState extends Equatable {
  const TelevisionPopularState();

  @override
  List<Object?> get props => [];
}

class TelevisionPopularInitial extends TelevisionPopularState {}

class TelevisionPopularLoadInProgress extends TelevisionPopularState {}

class TelevisionPopularLoadSuccess extends TelevisionPopularState {
  final List<Television> televisions;

  const TelevisionPopularLoadSuccess({
    required this.televisions,
  });

  @override
  List<Object?> get props => [televisions];
}

class TelevisionPopularLoadFailure extends TelevisionPopularState {
  final Object error;

  const TelevisionPopularLoadFailure({
    required this.error,
  });
  @override
  List<Object?> get props => [error];
}
