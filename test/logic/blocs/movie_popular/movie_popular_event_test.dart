import 'package:flutter_test/flutter_test.dart';
import 'package:movie/logic/blocs/movie_popular/movie_popular_bloc.dart';

void main() {
  group('MoviePopularEvent', () {
    group('MoviePopularLoaded', () {
      test('supports value equality', () {
        expect(MoviePopularLoaded(), MoviePopularLoaded());
      });

      test('props are correct', () {
        expect(
          MoviePopularLoaded().props,
          equals(<Object?>[]),
        );
      });
    });
  });
}
