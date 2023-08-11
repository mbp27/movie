import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

/// Use this function to launch maps by address
///
/// The arguments [address] are the query to find on maps
Future<void> launchMapsByAddress(String address) async {
  final Uri googleMapsUrl = Uri.parse(
      "https://www.google.com/maps/search/${Uri.encodeFull(address)}");
  final Uri appleMapsUrl =
      Uri.parse("https://maps.apple.com/?q=${Uri.encodeFull(address)}");

  try {
    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl);
    } else {
      if (Platform.isIOS) {
        if (await canLaunchUrl(appleMapsUrl)) {
          final nativeAppLaunchSucceeded = await launchUrl(
            appleMapsUrl,
            mode: LaunchMode.externalNonBrowserApplication,
          );
          if (!nativeAppLaunchSucceeded) {
            await launchUrl(
              appleMapsUrl,
              mode: LaunchMode.externalApplication,
            );
          }
        }
      } else {
        await launchUrl(
          googleMapsUrl,
          mode: LaunchMode.externalApplication,
        );
      }
    }
  } catch (e) {
    throw "Can't start Maps";
  }
}
