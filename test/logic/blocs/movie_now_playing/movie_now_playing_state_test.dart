import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/movie.dart';
import 'package:movie/logic/blocs/movie_now_playing/movie_now_playing_bloc.dart';

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

  group('MovieNowPlayingState', () {
    group('MovieNowPlayingInitial', () {
      test('supports value equality', () {
        expect(MovieNowPlayingInitial(), MovieNowPlayingInitial());
      });
    });

    group('MovieNowPlayingLoadInProgress', () {
      test('supports value equality', () {
        expect(
            MovieNowPlayingLoadInProgress(), MovieNowPlayingLoadInProgress());
      });
    });

    group('MovieNowPlayingLoadSuccess', () {
      MovieNowPlayingLoadSuccess createSubject({List<Movie>? movies}) {
        return MovieNowPlayingLoadSuccess(movies: movies ?? mockMovies);
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

    group('MovieNowPlayingLoadFailure', () {
      MovieNowPlayingLoadFailure createSubject({Object? error}) {
        return MovieNowPlayingLoadFailure(error: error ?? mockError);
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
