import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/television.dart';
import 'package:movie/logic/blocs/television_detail/television_detail_bloc.dart';

void main() {
  final mockError = Exception('Error');
  final mockTelevision = Television(
    id: 1,
    name: 'Television 1',
    overview: 'This is television 1',
  );

  group('TelevisionDetailState', () {
    group('TelevisionDetailInitial', () {
      test('supports value equality', () {
        expect(TelevisionDetailInitial(), TelevisionDetailInitial());
      });
    });

    group('TelevisionDetailLoadInProgress', () {
      test('supports value equality', () {
        expect(
            TelevisionDetailLoadInProgress(), TelevisionDetailLoadInProgress());
      });
    });

    group('TelevisionDetailLoadSuccess', () {
      TelevisionDetailLoadSuccess createSubject({Television? television}) {
        return TelevisionDetailLoadSuccess(
            television: television ?? mockTelevision);
      }

      test('supports value equality', () {
        expect(createSubject, equals(createSubject));
      });

      test('props are correct', () {
        expect(
          createSubject(television: mockTelevision).props,
          equals(<Object?>[mockTelevision]),
        );
      });
    });

    group('TelevisionDetailLoadFailure', () {
      TelevisionDetailLoadFailure createSubject({Object? error}) {
        return TelevisionDetailLoadFailure(error: error ?? mockError);
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
