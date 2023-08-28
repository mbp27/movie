import 'package:flutter_test/flutter_test.dart';
import 'package:movie/logic/blocs/television_on_the_air/television_on_the_air_bloc.dart';

void main() {
  group('TelevisionOnTheAirEvent', () {
    group('TelevisionOnTheAirLoaded', () {
      test('supports value equality', () {
        expect(TelevisionOnTheAirLoaded(), TelevisionOnTheAirLoaded());
      });

      test('props are correct', () {
        expect(
          TelevisionOnTheAirLoaded().props,
          equals(<Object?>[]),
        );
      });
    });
  });
}
