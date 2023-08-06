import 'package:flutter/material.dart';

class RatingBar extends StatelessWidget {
  const RatingBar({
    Key? key,
    required this.rating,
    this.size = 10.0,
  }) : super(key: key);

  final double rating;
  final double size;

  @override
  Widget build(BuildContext context) {
    final stars = <Widget>[];
    for (var i = 1; i <= 5; i++) {
      final color = i <= rating / 2
          ? Theme.of(context).primaryColor
          : Colors.grey.shade500;
      final star = Icon(Icons.star, color: color, size: size);
      stars.add(star);
    }
    return Row(mainAxisSize: MainAxisSize.min, children: stars);
  }
}
