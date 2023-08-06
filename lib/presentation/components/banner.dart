import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie/helpers/utils.dart';
import 'package:movie/presentation/components/loading.dart';

class Banner extends StatelessWidget {
  const Banner({
    Key? key,
    required this.title,
    this.imageUrl,
    this.onTap,
  }) : super(key: key);

  final String title;
  final String? imageUrl;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final imagePath = imageUrl;

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
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
                                const Center(
                              child: Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                            ),
                          );
                        } else {
                          return const Center(child: Loading());
                        }
                      },
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image_not_supported_outlined,
                            size: Utils.size(context).width / 8,
                          ),
                          const SizedBox(height: 4.0),
                          const Text('No Image'),
                        ],
                      ),
                    ),
            ),
            Positioned(
              left: 6.0,
              bottom: 6.0,
              right: Utils.size(context).width / 3,
              child: Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 0),
                      spreadRadius: 20,
                      blurRadius: 40,
                      color: Colors.black.withOpacity(0.6),
                    )
                  ],
                ),
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
