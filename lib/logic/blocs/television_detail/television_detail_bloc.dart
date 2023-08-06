import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/config.dart';
import 'package:movie/data/models/television.dart';
import 'package:movie/data/repositories/television_repository.dart';

part 'television_detail_event.dart';
part 'television_detail_state.dart';

class TelevisionDetailBloc
    extends Bloc<TelevisionDetailEvent, TelevisionDetailState> {
  final TelevisionRepository _televisionRepository;

  TelevisionDetailBloc({required TelevisionRepository televisionRepository})
      : _televisionRepository = televisionRepository,
        super(TelevisionDetailInitial()) {
    on<TelevisionDetailLoaded>(_onTelevisionDetailLoaded);
  }

  Future<void> _onTelevisionDetailLoaded(
    TelevisionDetailLoaded event,
    Emitter<TelevisionDetailState> emit,
  ) async {
    try {
      emit(TelevisionDetailLoadInProgress());
      final seriesId = event.television.id;
      if (seriesId == null) throw 'An error occurred.';
      final television = await _televisionRepository.getDetails(
          language: Config.defaultLanguage, seriesId: seriesId);
      if (television == null) throw 'No data found.';
      emit(TelevisionDetailLoadSuccess(television: television));
    } catch (e) {
      emit(TelevisionDetailLoadFailure(error: e));
    }
  }
}
