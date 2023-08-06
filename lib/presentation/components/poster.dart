import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie/helpers/utils.dart';
import 'package:movie/presentation/components/image_error.dart';
import 'package:movie/presentation/components/loading.dart';
import 'package:movie/presentation/components/no_image.dart';
import 'package:movie/presentation/components/rating_bar.dart';

class Poster extends StatelessWidget {
  const Poster({
    Key? key,
    required this.title,
    this.imageUrl,
    required this.voteAverage,
    this.onTap,
  }) : super(key: key);

  final String title;
  final String? imageUrl;
  final double voteAverage;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final imagePath = imageUrl;

    return GestureDetector(
      onTap: onTap,
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
                child: Container(
                  color: Colors.grey.shade900,
                  child: imagePath != null
                      ? FutureBuilder<File>(
                          future: Utils.downloadImage(imagePath),
                          builder: (context, snapshot) {
                            final file = snapshot.data;
                            if (file != null) {
                              return Image.file(
                                file,
                                fit: BoxFit.fill,
                                errorBuilder: (context, object, error) =>
                                    const Center(child: ImageError()),
                              );
                            } else {
                              return const Center(child: Loading());
                            }
                          },
                        )
                      : const Center(child: NoImage()),
                ),
              ),
            ),
            const SizedBox(height: 4.0),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RatingBar(rating: voteAverage),
                      const SizedBox(width: 4.0),
                      Text(
                        '$voteAverage',
                        style: const TextStyle(fontSize: 12.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12.0),
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
