import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/television.dart';
import 'package:movie/logic/blocs/television_detail/television_detail_bloc.dart';

void main() {
  final mockTelevision = Television(
    id: 1,
    name: 'Television 1',
    overview: 'This is television 1',
  );

  group('TelevisionDetailEvent', () {
    group('TelevisionDetailLoaded', () {
      test('supports value equality', () {
        expect(
          TelevisionDetailLoaded(television: mockTelevision),
          TelevisionDetailLoaded(television: mockTelevision),
        );
      });

      test('props are correct', () {
        expect(
          TelevisionDetailLoaded(television: mockTelevision).props,
          equals(<Object?>[mockTelevision]),
        );
      });
    });
  });
}
