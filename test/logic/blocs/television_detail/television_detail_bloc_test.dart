import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/config.dart';
import 'package:movie/data/models/television.dart';
import 'package:movie/data/repositories/television_repository.dart';
import 'package:movie/logic/blocs/television_detail/television_detail_bloc.dart';

import '../../../helper.dart';

class FakeTelevision extends Fake implements Television {}

void main() {
  final mockLanguage = Config.defaultLanguage;
  final mockError = Exception('Error');
  final mockTelevision = Television(
    id: 1,
    name: 'Television 1',
    overview: 'This is television 1',
  );
  const mockTelevisionId = 1;

  group('TelevisionDetailBloc', () {
    late TelevisionRepository televisionRepository;

    setUpAll(() {
      registerFallbackValue(FakeTelevision());
    });

    setUp(() {
      televisionRepository = MockTelevisionRepository();
      when(
        () => televisionRepository.getDetails(
            language: mockLanguage, seriesId: mockTelevisionId),
      ).thenAnswer((_) => Future.value(mockTelevision));
    });

    TelevisionDetailBloc buildBloc() {
      return TelevisionDetailBloc(televisionRepository: televisionRepository);
    }

    group('constructor', () {
      test('works properly', () => expect(buildBloc, returnsNormally));

      test('has correct initial state', () {
        expect(
          buildBloc().state,
          equals(TelevisionDetailInitial()),
        );
      });
    });

    group('TelevisionDetailLoaded', () {
      blocTest<TelevisionDetailBloc, TelevisionDetailState>(
        'emits [TelevisionDetailLoadInProgress, TelevisionDetailLoadFailure] '
        'when televisionId is null',
        build: buildBloc,
        act: (bloc) =>
            bloc.add(TelevisionDetailLoaded(television: Television(id: null))),
        expect: () => [
          TelevisionDetailLoadInProgress(),
          isA<TelevisionDetailLoadFailure>()
              .having((m) => m.error, 'error', 'An error occurred.'),
        ],
      );

      blocTest<TelevisionDetailBloc, TelevisionDetailState>(
        'calls getDetails with correct language and seriesId',
        build: buildBloc,
        act: (bloc) =>
            bloc.add(TelevisionDetailLoaded(television: mockTelevision)),
        verify: (_) {
          verify(() => televisionRepository.getDetails(
              language: mockLanguage, seriesId: mockTelevisionId)).called(1);
        },
      );

      blocTest<TelevisionDetailBloc, TelevisionDetailState>(
        'emits [TelevisionDetailLoadInProgress, TelevisionDetailLoadFailure] '
        'when getDetails throws',
        setUp: () {
          when(() => televisionRepository.getDetails(
                  language: mockLanguage, seriesId: mockTelevisionId))
              .thenAnswer((_) => Future.error(mockError));
        },
        build: buildBloc,
        act: (bloc) =>
            bloc.add(TelevisionDetailLoaded(television: mockTelevision)),
        expect: () => [
          TelevisionDetailLoadInProgress(),
          isA<TelevisionDetailLoadFailure>()
              .having((m) => m.error, 'error', mockError),
        ],
      );

      blocTest<TelevisionDetailBloc, TelevisionDetailState>(
        'emits [TelevisionDetailLoadInProgress, TelevisionDetailLoadSuccess] '
        'when getDetails returns (television)',
        build: buildBloc,
        act: (bloc) =>
            bloc.add(TelevisionDetailLoaded(television: mockTelevision)),
        expect: () => [
          TelevisionDetailLoadInProgress(),
          isA<TelevisionDetailLoadSuccess>()
              .having((m) => m.television, 'movie', mockTelevision)
        ],
      );
    });
  });
}
