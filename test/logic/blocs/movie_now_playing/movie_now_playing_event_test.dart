import 'package:flutter_test/flutter_test.dart';
import 'package:movie/logic/blocs/movie_now_playing/movie_now_playing_bloc.dart';

void main() {
  group('MovieNowPlayingEvent', () {
    group('MovieNowPlayingLoaded', () {
      test('supports value equality', () {
        expect(MovieNowPlayingLoaded(), MovieNowPlayingLoaded());
      });

      test('props are correct', () {
        expect(
          MovieNowPlayingLoaded().props,
          equals(<Object?>[]),
        );
      });
    });
  });
}
