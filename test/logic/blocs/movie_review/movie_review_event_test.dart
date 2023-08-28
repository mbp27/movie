import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/movie.dart';
import 'package:movie/logic/blocs/movie_review/movie_review_bloc.dart';

void main() {
  final mockMovie = Movie(
    id: 1,
    title: 'Movie 1',
    overview: 'This is movie 1',
  );

  group('MovieReviewEvent', () {
    group('MovieReviewLoaded', () {
      test('supports value equality', () {
        expect(
          MovieReviewLoaded(movie: mockMovie),
          MovieReviewLoaded(movie: mockMovie),
        );
      });

      test('props are correct', () {
        expect(
          MovieReviewLoaded(movie: mockMovie).props,
          equals(<Object?>[mockMovie]),
        );
      });
    });
  });
}
