import 'package:flutter/material.dart';
import 'package:movie/presentation/components/custom_shimmer.dart';

class PosterLoading extends StatelessWidget {
  const PosterLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      child: AspectRatio(
        aspectRatio: 1 / 1.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 1 / 1.4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: Container(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 8.0),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          color: Colors.grey,
                          height: 12.0,
                          width: 50.0,
                        ),
                      ),
                      const SizedBox(width: 4.0),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          color: Colors.grey,
                          height: 12.0,
                          width: 20.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6.0),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(color: Colors.grey, height: 12.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
