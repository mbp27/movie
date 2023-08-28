import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/movie.dart';
import 'package:movie/logic/blocs/movie_detail/movie_detail_bloc.dart';

void main() {
  final mockError = Exception('Error');
  final mockMovie = Movie(
    id: 1,
    title: 'Movie 1',
    overview: 'This is movie 1',
  );

  group('MovieDetailState', () {
    group('MovieDetailInitial', () {
      test('supports value equality', () {
        expect(MovieDetailInitial(), MovieDetailInitial());
      });
    });

    group('MovieDetailLoadInProgress', () {
      test('supports value equality', () {
        expect(MovieDetailLoadInProgress(), MovieDetailLoadInProgress());
      });
    });

    group('MovieDetailLoadSuccess', () {
      MovieDetailLoadSuccess createSubject({Movie? movie}) {
        return MovieDetailLoadSuccess(movie: movie ?? mockMovie);
      }

      test('supports value equality', () {
        expect(createSubject, equals(createSubject));
      });

      test('props are correct', () {
        expect(
          createSubject(movie: mockMovie).props,
          equals(<Object?>[mockMovie]),
        );
      });
    });

    group('MovieDetailLoadFailure', () {
      MovieDetailLoadFailure createSubject({Object? error}) {
        return MovieDetailLoadFailure(error: error ?? mockError);
      }

      test('supports value equality', () {
        expect(createSubject, equals(createSubject));
      });

      test('props are correct', () {
        expect(
          createSubject(error: mockError).props,
          equals(<Object?>[mockError]),
        );
      });
    });
  });
}
