import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/config.dart';
import 'package:movie/data/models/review.dart';
import 'package:movie/data/models/television.dart';
import 'package:movie/data/repositories/television_repository.dart';

part 'television_review_event.dart';
part 'television_review_state.dart';

class TelevisionReviewBloc
    extends Bloc<TelevisionReviewEvent, TelevisionReviewState> {
  final TelevisionRepository _televisionRepository;

  TelevisionReviewBloc({required TelevisionRepository televisionRepository})
      : _televisionRepository = televisionRepository,
        super(TelevisionReviewInitial()) {
    on<TelevisionReviewLoaded>(_onTelevisionReviewLoaded);
  }

  Future<void> _onTelevisionReviewLoaded(
    TelevisionReviewLoaded event,
    Emitter<TelevisionReviewState> emit,
  ) async {
    try {
      emit(TelevisionReviewLoadInProgress());
      final seriesId = event.television.id;
      if (seriesId == null) throw 'An error occurred.';
      final reviews = await _televisionRepository.getReviews(
              language: Config.defaultLanguage, page: 1, seriesId: seriesId) ??
          [];
      emit(TelevisionReviewLoadSuccess(reviews: reviews));
    } catch (e) {
      emit(TelevisionReviewLoadFailure(error: e));
    }
  }
}
