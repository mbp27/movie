import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/config.dart';
import 'package:movie/data/models/television.dart';
import 'package:movie/data/repositories/television_repository.dart';
import 'package:movie/logic/blocs/television_on_the_air/television_on_the_air_bloc.dart';

import '../../../helper.dart';

class FakeTelevision extends Fake implements Television {}

void main() {
  final mockLanguage = Config.defaultLanguage;
  const mockPage = 1;
  final mockError = Exception('Error');
  final mockTelevisions = [
    Television(
      id: 1,
      name: 'Television 1',
      overview: 'This is television 1',
    ),
    Television(
      id: 2,
      name: 'Television 2',
      overview: 'This is television 2',
    ),
    Television(
      id: 3,
      name: 'Television 3',
      overview: 'This is television 3',
    ),
  ];

  group('TelevisionOnTheAirBloc', () {
    late TelevisionRepository televisionRepository;

    setUpAll(() {
      registerFallbackValue(FakeTelevision());
    });

    setUp(() {
      televisionRepository = MockTelevisionRepository();
      when(
        () => televisionRepository.getOnTheAir(
            language: mockLanguage, page: mockPage),
      ).thenAnswer((_) => Future.value(mockTelevisions));
    });

    TelevisionOnTheAirBloc buildBloc() {
      return TelevisionOnTheAirBloc(televisionRepository: televisionRepository);
    }

    group('constructor', () {
      test('works properly', () => expect(buildBloc, returnsNormally));

      test('has correct initial state', () {
        expect(
          buildBloc().state,
          equals(TelevisionOnTheAirInitial()),
        );
      });
    });

    group('TelevisionOnTheAirLoaded', () {
      blocTest<TelevisionOnTheAirBloc, TelevisionOnTheAirState>(
        'calls getOnTheAir with correct language and page',
        build: buildBloc,
        act: (bloc) => bloc.add(TelevisionOnTheAirLoaded()),
        verify: (_) {
          verify(() => televisionRepository.getOnTheAir(
              language: mockLanguage, page: mockPage)).called(1);
        },
      );

      blocTest<TelevisionOnTheAirBloc, TelevisionOnTheAirState>(
        'emits [TelevisionOnTheAirLoadInProgress, TelevisionOnTheAirLoadFailure] '
        'when getOnTheAir throws',
        setUp: () {
          when(() => televisionRepository.getOnTheAir(
              language: mockLanguage,
              page: mockPage)).thenAnswer((_) => Future.error(mockError));
        },
        build: buildBloc,
        act: (bloc) => bloc.add(TelevisionOnTheAirLoaded()),
        expect: () => [
          TelevisionOnTheAirLoadInProgress(),
          isA<TelevisionOnTheAirLoadFailure>()
              .having((m) => m.error, 'error', mockError),
        ],
      );

      blocTest<TelevisionOnTheAirBloc, TelevisionOnTheAirState>(
        'emits [TelevisionOnTheAirLoadInProgress, TelevisionOnTheAirLoadSuccess] '
        'when getOnTheAir returns (televisions)',
        build: buildBloc,
        act: (bloc) => bloc.add(TelevisionOnTheAirLoaded()),
        expect: () => [
          TelevisionOnTheAirLoadInProgress(),
          isA<TelevisionOnTheAirLoadSuccess>()
              .having((m) => m.televisions, 'televisions', mockTelevisions)
        ],
      );
    });
  });
}
