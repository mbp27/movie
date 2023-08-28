import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/config.dart';
import 'package:movie/data/models/movie.dart';
import 'package:movie/data/models/review.dart';
import 'package:movie/data/repositories/movie_repository.dart';
import 'package:movie/logic/blocs/movie_review/movie_review_bloc.dart';

import '../../../helper.dart';

class FakeMovie extends Fake implements Movie {}

void main() {
  final mockLanguage = Config.defaultLanguage;
  const mockPage = 1;
  final mockError = Exception('Error');
  final mockMovie = Movie(
    id: 1,
    title: 'Movie 1',
    overview: 'This is movie 1',
  );
  const mockMovieId = 1;
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

  group('MovieReviewBloc', () {
    late MovieRepository movieRepository;

    setUpAll(() {
      registerFallbackValue(FakeMovie());
    });

    setUp(() {
      movieRepository = MockMovieRepository();
      when(
        () => movieRepository.getReviews(
            language: mockLanguage, page: mockPage, movieId: mockMovieId),
      ).thenAnswer((_) => Future.value(mockReviews));
    });

    MovieReviewBloc buildBloc() {
      return MovieReviewBloc(movieRepository: movieRepository);
    }

    group('constructor', () {
      test('works properly', () => expect(buildBloc, returnsNormally));

      test('has correct initial state', () {
        expect(
          buildBloc().state,
          equals(MovieReviewInitial()),
        );
      });
    });

    group('MovieReviewLoaded', () {
      blocTest<MovieReviewBloc, MovieReviewState>(
        'emits [MovieReviewLoadInProgress, MovieReviewLoadFailure] '
        'when movieId is null',
        build: buildBloc,
        act: (bloc) => bloc.add(MovieReviewLoaded(movie: Movie(id: null))),
        expect: () => [
          MovieReviewLoadInProgress(),
          isA<MovieReviewLoadFailure>()
              .having((m) => m.error, 'error', 'An error occurred.'),
        ],
      );

      blocTest<MovieReviewBloc, MovieReviewState>(
        'calls getReviews with correct language, page and movieId',
        build: buildBloc,
        act: (bloc) => bloc.add(MovieReviewLoaded(movie: mockMovie)),
        verify: (_) {
          verify(() => movieRepository.getReviews(
              language: mockLanguage,
              page: mockPage,
              movieId: mockMovieId)).called(1);
        },
      );

      blocTest<MovieReviewBloc, MovieReviewState>(
        'emits [MovieReviewLoadInProgress, MovieReviewLoadFailure] '
        'when getReviews throws',
        setUp: () {
          when(() => movieRepository.getReviews(
              language: mockLanguage,
              page: mockPage,
              movieId: mockMovieId)).thenAnswer((_) => Future.error(mockError));
        },
        build: buildBloc,
        act: (bloc) => bloc.add(MovieReviewLoaded(movie: mockMovie)),
        expect: () => [
          MovieReviewLoadInProgress(),
          isA<MovieReviewLoadFailure>()
              .having((m) => m.error, 'error', mockError),
        ],
      );

      blocTest<MovieReviewBloc, MovieReviewState>(
        'emits [MovieReviewLoadInProgress, MovieReviewLoadSuccess] '
        'when getReviews returns (reviews)',
        build: buildBloc,
        act: (bloc) => bloc.add(MovieReviewLoaded(movie: mockMovie)),
        expect: () => [
          MovieReviewLoadInProgress(),
          isA<MovieReviewLoadSuccess>()
              .having((m) => m.reviews, 'reviews', mockReviews)
        ],
      );
    });
  });
}
