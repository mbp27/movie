import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  final Widget child;
  final Duration period;
  final ShimmerDirection direction;
  final int loop;
  final bool enabled;
  final MaterialColor color;

  const CustomShimmer({
    Key? key,
    required this.child,
    this.period = const Duration(milliseconds: 1500),
    this.direction = ShimmerDirection.ltr,
    this.loop = 0,
    this.enabled = true,
    this.color = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: color.shade900,
      highlightColor: color.shade800,
      direction: direction,
      period: period,
      loop: loop,
      enabled: enabled,
      child: child,
    );
  }
}
