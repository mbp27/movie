import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/television.dart';
import 'package:movie/logic/blocs/television_popular/television_popular_bloc.dart';

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

  group('TelevisionPopularState', () {
    group('TelevisionPopularInitial', () {
      test('supports value equality', () {
        expect(TelevisionPopularInitial(), TelevisionPopularInitial());
      });
    });

    group('TelevisionPopularLoadInProgress', () {
      test('supports value equality', () {
        expect(TelevisionPopularLoadInProgress(),
            TelevisionPopularLoadInProgress());
      });
    });

    group('TelevisionPopularLoadSuccess', () {
      TelevisionPopularLoadSuccess createSubject(
          {List<Television>? televisions}) {
        return TelevisionPopularLoadSuccess(
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

    group('TelevisionPopularLoadFailure', () {
      TelevisionPopularLoadFailure createSubject({Object? error}) {
        return TelevisionPopularLoadFailure(error: error ?? mockError);
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
