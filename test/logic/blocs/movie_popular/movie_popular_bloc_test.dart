import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/config.dart';
import 'package:movie/data/models/movie.dart';
import 'package:movie/data/repositories/movie_repository.dart';
import 'package:movie/logic/blocs/movie_popular/movie_popular_bloc.dart';

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

  group('MoviePopularBloc', () {
    late MovieRepository movieRepository;

    setUpAll(() {
      registerFallbackValue(FakeMovie());
    });

    setUp(() {
      movieRepository = MockMovieRepository();
      when(
        () =>
            movieRepository.getPopular(language: mockLanguage, page: mockPage),
      ).thenAnswer((_) => Future.value(mockMovies));
    });

    MoviePopularBloc buildBloc() {
      return MoviePopularBloc(movieRepository: movieRepository);
    }

    group('constructor', () {
      test('works properly', () => expect(buildBloc, returnsNormally));

      test('has correct initial state', () {
        expect(
          buildBloc().state,
          equals(MoviePopularInitial()),
        );
      });
    });

    group('MoviePopularLoaded', () {
      blocTest<MoviePopularBloc, MoviePopularState>(
        'calls getPopular with correct language and page',
        build: buildBloc,
        act: (bloc) => bloc.add(MoviePopularLoaded()),
        verify: (_) {
          verify(() => movieRepository.getPopular(
              language: mockLanguage, page: mockPage)).called(1);
        },
      );

      blocTest<MoviePopularBloc, MoviePopularState>(
        'emits [MoviePopularLoadInProgress, MoviePopularLoadFailure] '
        'when getPopular throws',
        setUp: () {
          when(() => movieRepository.getPopular(
              language: mockLanguage,
              page: mockPage)).thenAnswer((_) => Future.error(mockError));
        },
        build: buildBloc,
        act: (bloc) => bloc.add(MoviePopularLoaded()),
        expect: () => [
          MoviePopularLoadInProgress(),
          isA<MoviePopularLoadFailure>()
              .having((m) => m.error, 'error', mockError),
        ],
      );

      blocTest<MoviePopularBloc, MoviePopularState>(
        'emits [MoviePopularLoadInProgress, MoviePopularLoadSuccess] '
        'when getPopular returns (movies)',
        build: buildBloc,
        act: (bloc) => bloc.add(MoviePopularLoaded()),
        expect: () => [
          MoviePopularLoadInProgress(),
          isA<MoviePopularLoadSuccess>()
              .having((m) => m.movies, 'movies', mockMovies)
        ],
      );
    });
  });
}
