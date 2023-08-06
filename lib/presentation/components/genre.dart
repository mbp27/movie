import 'package:flutter/material.dart';
import 'package:movie/data/models/genre.dart';

class RatingBar extends StatelessWidget {
  const RatingBar({
    Key? key,
    required this.genres,
    this.size = 10.0,
  }) : super(key: key);

  final List<Genre> genres;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: genres
          .map((e) => Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  '${e.name}',
                  style: TextStyle(fontSize: size),
                ),
              ))
          .toList(),
    );
  }
}
