import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/television.dart';
import 'package:movie/logic/blocs/television_review/television_review_bloc.dart';

void main() {
  final mockTelevision = Television(
    id: 1,
    name: 'Television 1',
    overview: 'This is television 1',
  );

  group('TelevisionReviewEvent', () {
    group('TelevisionReviewLoaded', () {
      test('supports value equality', () {
        expect(
          TelevisionReviewLoaded(television: mockTelevision),
          TelevisionReviewLoaded(television: mockTelevision),
        );
      });

      test('props are correct', () {
        expect(
          TelevisionReviewLoaded(television: mockTelevision).props,
          equals(<Object?>[mockTelevision]),
        );
      });
    });
  });
}
