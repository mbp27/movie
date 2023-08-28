import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/movie.dart';
import 'package:movie/logic/blocs/movie_detail/movie_detail_bloc.dart';

void main() {
  final mockMovie = Movie(
    id: 1,
    title: 'Movie 1',
    overview: 'This is movie 1',
  );

  group('MovieDetailEvent', () {
    group('MovieDetailLoaded', () {
      test('supports value equality', () {
        expect(
          MovieDetailLoaded(movie: mockMovie),
          MovieDetailLoaded(movie: mockMovie),
        );
      });

      test('props are correct', () {
        expect(
          MovieDetailLoaded(movie: mockMovie).props,
          equals(<Object?>[mockMovie]),
        );
      });
    });
  });
}
