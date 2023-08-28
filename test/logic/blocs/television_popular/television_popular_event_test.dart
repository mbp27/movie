import 'package:flutter_test/flutter_test.dart';
import 'package:movie/logic/blocs/television_popular/television_popular_bloc.dart';

void main() {
  group('TelevisionPopularEvent', () {
    group('TelevisionPopularLoaded', () {
      test('supports value equality', () {
        expect(TelevisionPopularLoaded(), TelevisionPopularLoaded());
      });

      test('props are correct', () {
        expect(
          TelevisionPopularLoaded().props,
          equals(<Object?>[]),
        );
      });
    });
  });
}
