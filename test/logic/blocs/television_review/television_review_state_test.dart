import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/review.dart';
import 'package:movie/logic/blocs/television_review/television_review_bloc.dart';

void main() {
  final mockError = Exception('Error');
  final mockReviews = [
    Review(
      id: '1',
      author: 'Review 1',
      content: 'This is review 1',
    ),
    Review(
      id: '2',
      author: 'Review 2',
      content: 'This is review 2',
    ),
    Review(
      id: '3',
      author: 'Review 3',
      content: 'This is review 3',
    ),
  ];

  group('TelevisionReviewState', () {
    group('TelevisionReviewInitial', () {
      test('supports value equality', () {
        expect(TelevisionReviewInitial(), TelevisionReviewInitial());
      });
    });

    group('TelevisionReviewLoadInProgress', () {
      test('supports value equality', () {
        expect(
            TelevisionReviewLoadInProgress(), TelevisionReviewLoadInProgress());
      });
    });

    group('TelevisionReviewLoadSuccess', () {
      TelevisionReviewLoadSuccess createSubject({List<Review>? reviews}) {
        return TelevisionReviewLoadSuccess(reviews: reviews ?? mockReviews);
      }

      test('supports value equality', () {
        expect(createSubject, equals(createSubject));
      });

      test('props are correct', () {
        expect(
          createSubject(reviews: mockReviews).props,
          equals(<Object?>[mockReviews]),
        );
      });
    });

    group('TelevisionReviewLoadFailure', () {
      TelevisionReviewLoadFailure createSubject({Object? error}) {
        return TelevisionReviewLoadFailure(error: error ?? mockError);
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
