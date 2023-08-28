import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/review.dart';
import 'package:movie/logic/blocs/movie_review/movie_review_bloc.dart';

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

  group('MovieReviewState', () {
    group('MovieReviewInitial', () {
      test('supports value equality', () {
        expect(MovieReviewInitial(), MovieReviewInitial());
      });
    });

    group('MovieReviewLoadInProgress', () {
      test('supports value equality', () {
        expect(MovieReviewLoadInProgress(), MovieReviewLoadInProgress());
      });
    });

    group('MovieReviewLoadSuccess', () {
      MovieReviewLoadSuccess createSubject({List<Review>? reviews}) {
        return MovieReviewLoadSuccess(reviews: reviews ?? mockReviews);
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

    group('MovieReviewLoadFailure', () {
      MovieReviewLoadFailure createSubject({Object? error}) {
        return MovieReviewLoadFailure(error: error ?? mockError);
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
