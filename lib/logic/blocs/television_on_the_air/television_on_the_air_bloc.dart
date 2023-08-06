import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/config.dart';
import 'package:movie/data/models/television.dart';
import 'package:movie/data/repositories/television_repository.dart';

part 'television_on_the_air_event.dart';
part 'television_on_the_air_state.dart';

class TelevisionOnTheAirBloc
    extends Bloc<TelevisionOnTheAirEvent, TelevisionOnTheAirState> {
  final TelevisionRepository _televisionRepository;

  TelevisionOnTheAirBloc({required TelevisionRepository televisionRepository})
      : _televisionRepository = televisionRepository,
        super(TelevisionOnTheAirInitial()) {
    on<TelevisionOnTheAirLoaded>(_onTelevisionOnTheAirLoaded);
  }

  Future<void> _onTelevisionOnTheAirLoaded(
    TelevisionOnTheAirLoaded event,
    Emitter<TelevisionOnTheAirState> emit,
  ) async {
    try {
      emit(TelevisionOnTheAirLoadInProgress());
      final televisions = await _televisionRepository.getOnTheAir(
              language: Config.defaultLanguage, page: 1) ??
          [];
      emit(TelevisionOnTheAirLoadSuccess(televisions: televisions));
    } catch (e) {
      emit(TelevisionOnTheAirLoadFailure(error: e));
    }
  }
}
