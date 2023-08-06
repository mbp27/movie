part of 'television_detail_bloc.dart';

abstract class TelevisionDetailState extends Equatable {
  const TelevisionDetailState();

  @override
  List<Object?> get props => [];
}

class TelevisionDetailInitial extends TelevisionDetailState {}

class TelevisionDetailLoadInProgress extends TelevisionDetailState {}

class TelevisionDetailLoadSuccess extends TelevisionDetailState {
  final Television television;

  const TelevisionDetailLoadSuccess({
    required this.television,
  });

  @override
  List<Object?> get props => [television];
}

class TelevisionDetailLoadFailure extends TelevisionDetailState {
  final Object error;

  const TelevisionDetailLoadFailure({
    required this.error,
  });
  @override
  List<Object?> get props => [error];
}
