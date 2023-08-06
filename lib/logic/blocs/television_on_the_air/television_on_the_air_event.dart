part of 'television_on_the_air_bloc.dart';

abstract class TelevisionOnTheAirEvent extends Equatable {
  const TelevisionOnTheAirEvent();

  @override
  List<Object?> get props => [];
}

class TelevisionOnTheAirLoaded extends TelevisionOnTheAirEvent {}
