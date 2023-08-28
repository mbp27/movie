import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/television.dart';
import 'package:movie/logic/blocs/television_on_the_air/television_on_the_air_bloc.dart';

void main() {
  final mockError = Exception('Error');
  final mockTelevisions = [
    Television(
      id: 1,
      name: 'Television 1',
      overview: 'This is movie 1',
    ),
    Television(
      id: 2,
      name: 'Television 2',
      overview: 'This is movie 2',
    ),
    Television(
      id: 3,
      name: 'Television 3',
      overview: 'This is movie 3',
    ),
  ];

  group('TelevisionOnTheAirState', () {
    group('TelevisionOnTheAirInitial', () {
      test('supports value equality', () {
        expect(TelevisionOnTheAirInitial(), TelevisionOnTheAirInitial());
      });
    });

    group('TelevisionOnTheAirLoadInProgress', () {
      test('supports value equality', () {
        expect(TelevisionOnTheAirLoadInProgress(),
            TelevisionOnTheAirLoadInProgress());
      });
    });

    group('TelevisionOnTheAirLoadSuccess', () {
      TelevisionOnTheAirLoadSuccess createSubject(
          {List<Television>? televisions}) {
        return TelevisionOnTheAirLoadSuccess(
            televisions: televisions ?? mockTelevisions);
      }

      test('supports value equality', () {
        expect(createSubject, equals(createSubject));
      });

      test('props are correct', () {
        expect(
          createSubject(televisions: mockTelevisions).props,
          equals(<Object?>[mockTelevisions]),
        );
      });
    });

    group('TelevisionOnTheAirLoadFailure', () {
      TelevisionOnTheAirLoadFailure createSubject({Object? error}) {
        return TelevisionOnTheAirLoadFailure(error: error ?? mockError);
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
