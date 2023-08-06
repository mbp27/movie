import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class Utils {
  /// Get the size of device with context
  static Size size(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  /// Get the orientation of device with context
  static Orientation orientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  /// Downloading image from url and save it to temp directory
  static Future<File> downloadImage(String url) async {
    final temp = await getTemporaryDirectory();
    final filename = url.substring(url.lastIndexOf('/') + 1);
    final imageFile = File('${temp.path}/images/$filename');

    if (!(imageFile.existsSync())) {
      // Image doesn't exist in cache
      // Download the image and write to above file
      final response = await http.get(Uri.parse(url));
      // Creating file image
      await imageFile.create(recursive: true);
      // Write file from downloaded image
      await imageFile.writeAsBytes(response.bodyBytes);
    }
    return imageFile;
  }
}
