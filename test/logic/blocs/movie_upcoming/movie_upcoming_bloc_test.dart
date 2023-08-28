import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/config.dart';
import 'package:movie/data/models/movie.dart';
import 'package:movie/data/repositories/movie_repository.dart';
import 'package:movie/logic/blocs/movie_upcoming/movie_upcoming_bloc.dart';

import '../../../helper.dart';

class FakeMovie extends Fake implements Movie {}

void main() {
  final mockLanguage = Config.defaultLanguage;
  const mockPage = 1;
  final mockError = Exception('Error');
  final mockMovies = [
    Movie(
      id: 1,
      title: 'Movie 1',
      overview: 'This is movie 1',
    ),
    Movie(
      id: 2,
      title: 'Movie 2',
      overview: 'This is movie 2',
    ),
    Movie(
      id: 3,
      title: 'Movie 3',
      overview: 'This is movie 3',
    ),
  ];

  group('MovieUpcomingBloc', () {
    late MovieRepository movieRepository;

    setUpAll(() {
      registerFallbackValue(FakeMovie());
    });

    setUp(() {
      movieRepository = MockMovieRepository();
      when(
        () =>
            movieRepository.getUpcoming(language: mockLanguage, page: mockPage),
      ).thenAnswer((_) => Future.value(mockMovies));
    });

    MovieUpcomingBloc buildBloc() {
      return MovieUpcomingBloc(movieRepository: movieRepository);
    }

    group('constructor', () {
      test('works properly', () => expect(buildBloc, returnsNormally));

      test('has correct initial state', () {
        expect(
          buildBloc().state,
          equals(MovieUpcomingInitial()),
        );
      });
    });

    group('MovieUpcomingLoaded', () {
      blocTest<MovieUpcomingBloc, MovieUpcomingState>(
        'calls getUpcoming with correct language and page',
        build: buildBloc,
        act: (bloc) => bloc.add(MovieUpcomingLoaded()),
        verify: (_) {
          verify(() => movieRepository.getUpcoming(
              language: mockLanguage, page: mockPage)).called(1);
        },
      );

      blocTest<MovieUpcomingBloc, MovieUpcomingState>(
        'emits [MovieUpcomingLoadInProgress, MovieUpcomingLoadFailure] '
        'when getUpcoming throws',
        setUp: () {
          when(() => movieRepository.getUpcoming(
              language: mockLanguage,
              page: mockPage)).thenAnswer((_) => Future.error(mockError));
        },
        build: buildBloc,
        act: (bloc) => bloc.add(MovieUpcomingLoaded()),
        expect: () => [
          MovieUpcomingLoadInProgress(),
          isA<MovieUpcomingLoadFailure>()
              .having((m) => m.error, 'error', mockError),
        ],
      );

      blocTest<MovieUpcomingBloc, MovieUpcomingState>(
        'emits [MovieUpcomingLoadInProgress, MovieUpcomingLoadSuccess] '
        'when getUpcoming returns (movies)',
        build: buildBloc,
        act: (bloc) => bloc.add(MovieUpcomingLoaded()),
        expect: () => [
          MovieUpcomingLoadInProgress(),
          isA<MovieUpcomingLoadSuccess>()
              .having((m) => m.movies, 'movies', mockMovies)
        ],
      );
    });
  });
}
