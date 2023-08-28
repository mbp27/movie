import 'package:flutter_test/flutter_test.dart';
import 'package:movie/logic/blocs/movie_upcoming/movie_upcoming_bloc.dart';

void main() {
  group('MovieUpcomingEvent', () {
    group('MovieUpcomingLoaded', () {
      test('supports value equality', () {
        expect(MovieUpcomingLoaded(), MovieUpcomingLoaded());
      });

      test('props are correct', () {
        expect(
          MovieUpcomingLoaded().props,
          equals(<Object?>[]),
        );
      });
    });
  });
}
