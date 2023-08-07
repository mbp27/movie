import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie/data/models/review.dart';
import 'package:movie/presentation/components/rating_bar.dart';

class ReviewWidget extends StatefulWidget {
  const ReviewWidget({
    Key? key,
    required this.review,
  }) : super(key: key);

  final Review review;

  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final rating = widget.review.authorDetails?.rating?.toDouble() ?? 0;
    final createdAt = widget.review.createdAt;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.review.author}',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4.0),
            Row(
              children: [
                RatingBar(rating: rating, size: 14.0),
                const SizedBox(width: 4.0),
                Text(
                  '${createdAt != null ? DateFormat('yyyy-MM-dd').format(createdAt) : null}',
                  style: const TextStyle(fontSize: 12.0),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Column(
            children: [
              Text(
                '${widget.review.content}',
                overflow: _isExpanded ? null : TextOverflow.ellipsis,
                maxLines: _isExpanded ? null : 4,
                style: const TextStyle(fontSize: 12.0),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'show ${_isExpanded ? 'less' : 'more'}',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
