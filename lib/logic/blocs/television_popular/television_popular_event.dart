part of 'television_popular_bloc.dart';

abstract class TelevisionPopularEvent extends Equatable {
  const TelevisionPopularEvent();

  @override
  List<Object?> get props => [];
}

class TelevisionPopularLoaded extends TelevisionPopularEvent {}
