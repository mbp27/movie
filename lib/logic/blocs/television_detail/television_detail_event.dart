part of 'television_detail_bloc.dart';

abstract class TelevisionDetailEvent extends Equatable {
  const TelevisionDetailEvent();

  @override
  List<Object?> get props => [];
}

class TelevisionDetailLoaded extends TelevisionDetailEvent {
  final Television television;

  const TelevisionDetailLoaded({
    required this.television,
  });

  @override
  List<Object?> get props => [television];
}
