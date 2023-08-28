import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/config.dart';
import 'package:movie/data/models/review.dart';
import 'package:movie/data/models/television.dart';
import 'package:movie/data/repositories/television_repository.dart';
import 'package:movie/logic/blocs/television_review/television_review_bloc.dart';

import '../../../helper.dart';

class FakeTelevision extends Fake implements Television {}

void main() {
  final mockLanguage = Config.defaultLanguage;
  const mockPage = 1;
  final mockError = Exception('Error');
  final mockTelevision = Television(
    id: 1,
    name: 'Television 1',
    overview: 'This is television 1',
  );
  const mockTelevisionId = 1;
  final mockReviews = [
    Review(
      id: '1',
      author: 'Review 1',
      content: 'This is review 1',
    ),
    Review(
      id: '2',
      author: 'Review 2',
      content: 'This is review 2',
    ),
    Review(
      id: '3',
      author: 'Review 3',
      content: 'This is review 3',
    ),
  ];

  group('TelevisionReviewBloc', () {
    late TelevisionRepository televisionRepository;

    setUpAll(() {
      registerFallbackValue(FakeTelevision());
    });

    setUp(() {
      televisionRepository = MockTelevisionRepository();
      when(
        () => televisionRepository.getReviews(
            language: mockLanguage, page: mockPage, seriesId: mockTelevisionId),
      ).thenAnswer((_) => Future.value(mockReviews));
    });

    TelevisionReviewBloc buildBloc() {
      return TelevisionReviewBloc(televisionRepository: televisionRepository);
    }

    group('constructor', () {
      test('works properly', () => expect(buildBloc, returnsNormally));

      test('has correct initial state', () {
        expect(
          buildBloc().state,
          equals(TelevisionReviewInitial()),
        );
      });
    });

    group('TelevisionReviewLoaded', () {
      blocTest<TelevisionReviewBloc, TelevisionReviewState>(
        'emits [TelevisionReviewLoadInProgress, TelevisionReviewLoadFailure] '
        'when televisionId is null',
        build: buildBloc,
        act: (bloc) =>
            bloc.add(TelevisionReviewLoaded(television: Television(id: null))),
        expect: () => [
          TelevisionReviewLoadInProgress(),
          isA<TelevisionReviewLoadFailure>()
              .having((m) => m.error, 'error', 'An error occurred.'),
        ],
      );

      blocTest<TelevisionReviewBloc, TelevisionReviewState>(
        'calls getReviews with correct language, page and seriesId',
        build: buildBloc,
        act: (bloc) =>
            bloc.add(TelevisionReviewLoaded(television: mockTelevision)),
        verify: (_) {
          verify(() => televisionRepository.getReviews(
              language: mockLanguage,
              page: mockPage,
              seriesId: mockTelevisionId)).called(1);
        },
      );

      blocTest<TelevisionReviewBloc, TelevisionReviewState>(
        'emits [TelevisionReviewLoadInProgress, TelevisionReviewLoadFailure] '
        'when getReviews throws',
        setUp: () {
          when(() => televisionRepository.getReviews(
                  language: mockLanguage,
                  page: mockPage,
                  seriesId: mockTelevisionId))
              .thenAnswer((_) => Future.error(mockError));
        },
        build: buildBloc,
        act: (bloc) =>
            bloc.add(TelevisionReviewLoaded(television: mockTelevision)),
        expect: () => [
          TelevisionReviewLoadInProgress(),
          isA<TelevisionReviewLoadFailure>()
              .having((m) => m.error, 'error', mockError),
        ],
      );

      blocTest<TelevisionReviewBloc, TelevisionReviewState>(
        'emits [TelevisionReviewLoadInProgress, TelevisionReviewLoadSuccess] '
        'when getReviews returns (reviews)',
        build: buildBloc,
        act: (bloc) =>
            bloc.add(TelevisionReviewLoaded(television: mockTelevision)),
        expect: () => [
          TelevisionReviewLoadInProgress(),
          isA<TelevisionReviewLoadSuccess>()
              .having((m) => m.reviews, 'reviews', mockReviews)
        ],
      );
    });
  });
}
