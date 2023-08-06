import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/config.dart';
import 'package:movie/data/models/television.dart';
import 'package:movie/data/repositories/television_repository.dart';

part 'television_popular_event.dart';
part 'television_popular_state.dart';

class TelevisionPopularBloc
    extends Bloc<TelevisionPopularEvent, TelevisionPopularState> {
  final TelevisionRepository _televisionRepository;

  TelevisionPopularBloc({required TelevisionRepository televisionRepository})
      : _televisionRepository = televisionRepository,
        super(TelevisionPopularInitial()) {
    on<TelevisionPopularLoaded>(_onTelevisionPopularLoaded);
  }

  Future<void> _onTelevisionPopularLoaded(
    TelevisionPopularLoaded event,
    Emitter<TelevisionPopularState> emit,
  ) async {
    try {
      emit(TelevisionPopularLoadInProgress());
      final televisions = await _televisionRepository.getPopular(
              language: Config.defaultLanguage, page: 1) ??
          [];
      emit(TelevisionPopularLoadSuccess(televisions: televisions));
    } catch (e) {
      emit(TelevisionPopularLoadFailure(error: e));
    }
  }
}
