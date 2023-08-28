import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/config.dart';
import 'package:movie/data/models/movie.dart';
import 'package:movie/data/repositories/movie_repository.dart';
import 'package:movie/logic/blocs/movie_detail/movie_detail_bloc.dart';

import '../../../helper.dart';

class FakeMovie extends Fake implements Movie {}

void main() {
  final mockLanguage = Config.defaultLanguage;
  final mockError = Exception('Error');
  final mockMovie = Movie(
    id: 1,
    title: 'Movie 1',
    overview: 'This is movie 1',
  );
  const mockMovieId = 1;

  group('MovieDetailBloc', () {
    late MovieRepository movieRepository;

    setUpAll(() {
      registerFallbackValue(FakeMovie());
    });

    setUp(() {
      movieRepository = MockMovieRepository();
      when(
        () => movieRepository.getDetails(
            language: mockLanguage, movieId: mockMovieId),
      ).thenAnswer((_) => Future.value(mockMovie));
    });

    MovieDetailBloc buildBloc() {
      return MovieDetailBloc(movieRepository: movieRepository);
    }

    group('constructor', () {
      test('works properly', () => expect(buildBloc, returnsNormally));

      test('has correct initial state', () {
        expect(
          buildBloc().state,
          equals(MovieDetailInitial()),
        );
      });
    });

    group('MovieDetailLoaded', () {
      blocTest<MovieDetailBloc, MovieDetailState>(
        'emits [MovieDetailLoadInProgress, MovieDetailLoadFailure] '
        'when movieId is null',
        build: buildBloc,
        act: (bloc) => bloc.add(MovieDetailLoaded(movie: Movie(id: null))),
        expect: () => [
          MovieDetailLoadInProgress(),
          isA<MovieDetailLoadFailure>()
              .having((m) => m.error, 'error', 'An error occurred.'),
        ],
      );

      blocTest<MovieDetailBloc, MovieDetailState>(
        'calls getDetails with correct language and movieId',
        build: buildBloc,
        act: (bloc) => bloc.add(MovieDetailLoaded(movie: mockMovie)),
        verify: (_) {
          verify(() => movieRepository.getDetails(
              language: mockLanguage, movieId: mockMovieId)).called(1);
        },
      );

      blocTest<MovieDetailBloc, MovieDetailState>(
        'emits [MovieDetailLoadInProgress, MovieDetailLoadFailure] '
        'when getDetails throws',
        setUp: () {
          when(() => movieRepository.getDetails(
              language: mockLanguage,
              movieId: mockMovieId)).thenAnswer((_) => Future.error(mockError));
        },
        build: buildBloc,
        act: (bloc) => bloc.add(MovieDetailLoaded(movie: mockMovie)),
        expect: () => [
          MovieDetailLoadInProgress(),
          isA<MovieDetailLoadFailure>()
              .having((m) => m.error, 'error', mockError),
        ],
      );

      blocTest<MovieDetailBloc, MovieDetailState>(
        'emits [MovieDetailLoadInProgress, MovieDetailLoadSuccess] '
        'when getDetails returns (movie)',
        build: buildBloc,
        act: (bloc) => bloc.add(MovieDetailLoaded(movie: mockMovie)),
        expect: () => [
          MovieDetailLoadInProgress(),
          isA<MovieDetailLoadSuccess>()
              .having((m) => m.movie, 'movie', mockMovie)
        ],
      );
    });
  });
}
