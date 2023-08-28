import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/config.dart';
import 'package:movie/data/models/movie.dart';
import 'package:movie/data/repositories/movie_repository.dart';
import 'package:movie/logic/blocs/movie_now_playing/movie_now_playing_bloc.dart';

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

  group('MovieNowPlayingBloc', () {
    late MovieRepository movieRepository;

    setUpAll(() {
      registerFallbackValue(FakeMovie());
    });

    setUp(() {
      movieRepository = MockMovieRepository();
      when(
        () => movieRepository.getNowPlaying(
            language: mockLanguage, page: mockPage),
      ).thenAnswer((_) => Future.value(mockMovies));
    });

    MovieNowPlayingBloc buildBloc() {
      return MovieNowPlayingBloc(movieRepository: movieRepository);
    }

    group('constructor', () {
      test('works properly', () => expect(buildBloc, returnsNormally));

      test('has correct initial state', () {
        expect(
          buildBloc().state,
          equals(MovieNowPlayingInitial()),
        );
      });
    });

    group('MovieNowPlayingLoaded', () {
      blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
        'calls getNowPlaying with correct language and page',
        build: buildBloc,
        act: (bloc) => bloc.add(MovieNowPlayingLoaded()),
        verify: (_) {
          verify(() => movieRepository.getNowPlaying(
              language: mockLanguage, page: mockPage)).called(1);
        },
      );

      blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
        'emits [MovieNowPlayingLoadInProgress, MovieNowPlayingLoadFailure] '
        'when getNowPlaying throws',
        setUp: () {
          when(() => movieRepository.getNowPlaying(
              language: mockLanguage,
              page: mockPage)).thenAnswer((_) => Future.error(mockError));
        },
        build: buildBloc,
        act: (bloc) => bloc.add(MovieNowPlayingLoaded()),
        expect: () => [
          MovieNowPlayingLoadInProgress(),
          isA<MovieNowPlayingLoadFailure>()
              .having((m) => m.error, 'error', mockError),
        ],
      );

      blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
        'emits [MovieNowPlayingLoadInProgress, MovieNowPlayingLoadSuccess] '
        'when getNowPlaying returns (movies)',
        build: buildBloc,
        act: (bloc) => bloc.add(MovieNowPlayingLoaded()),
        expect: () => [
          MovieNowPlayingLoadInProgress(),
          isA<MovieNowPlayingLoadSuccess>()
              .having((m) => m.movies, 'movies', mockMovies)
        ],
      );
    });
  });
}
