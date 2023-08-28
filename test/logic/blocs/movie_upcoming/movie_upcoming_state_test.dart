import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/movie.dart';
import 'package:movie/logic/blocs/movie_upcoming/movie_upcoming_bloc.dart';

void main() {
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

  group('MovieUpcomingState', () {
    group('MovieUpcomingInitial', () {
      test('supports value equality', () {
        expect(MovieUpcomingInitial(), MovieUpcomingInitial());
      });
    });

    group('MovieUpcomingLoadInProgress', () {
      test('supports value equality', () {
        expect(MovieUpcomingLoadInProgress(), MovieUpcomingLoadInProgress());
      });
    });

    group('MovieUpcomingLoadSuccess', () {
      MovieUpcomingLoadSuccess createSubject({List<Movie>? movies}) {
        return MovieUpcomingLoadSuccess(movies: movies ?? mockMovies);
      }

      test('supports value equality', () {
        expect(createSubject, equals(createSubject));
      });

      test('props are correct', () {
        expect(
          createSubject(movies: mockMovies).props,
          equals(<Object?>[mockMovies]),
        );
      });
    });

    group('MovieUpcomingLoadFailure', () {
      MovieUpcomingLoadFailure createSubject({Object? error}) {
        return MovieUpcomingLoadFailure(error: error ?? mockError);
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
