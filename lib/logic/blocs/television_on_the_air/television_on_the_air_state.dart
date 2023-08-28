part of 'television_on_the_air_bloc.dart';

class TelevisionOnTheAirState extends Equatable {
  const TelevisionOnTheAirState();

  @override
  List<Object?> get props => [];
}

class TelevisionOnTheAirInitial extends TelevisionOnTheAirState {}

class TelevisionOnTheAirLoadInProgress extends TelevisionOnTheAirState {}

class TelevisionOnTheAirLoadSuccess extends TelevisionOnTheAirState {
  final List<Television> televisions;

  const TelevisionOnTheAirLoadSuccess({
    required this.televisions,
  });

  @override
  List<Object?> get props => [televisions];
}

class TelevisionOnTheAirLoadFailure extends TelevisionOnTheAirState {
  final Object error;

  const TelevisionOnTheAirLoadFailure({
    required this.error,
  });
  @override
  List<Object?> get props => [error];
}
