import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static const String routeName = '/about';

  @override
  Widget build(BuildContext context) {
    final mounted = context.mounted;

    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: 'This is Movie Mobile Application with integrating '
                      'API from ',
                ),
                TextSpan(
                  text: 'The Movie Database (TMDB)',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      try {
                        await launchUrl(
                          Uri.parse('https://www.themoviedb.org/'),
                          mode: LaunchMode.externalApplication,
                        );
                      } catch (e) {
                        if (!mounted) return;
                        ScaffoldMessenger.of(context)
                          ..clearSnackBars()
                          ..showSnackBar(
                            SnackBar(
                              content: Text('$e'),
                              duration: const Duration(seconds: 3),
                            ),
                          );
                      }
                    },
                ),
                const TextSpan(
                  text: '. This Movie Application made FOR portfolio '
                      'demonstration purpose only, NOT for commercial use.'
                      '\n\n'
                      'Any inquire? Please contact via socials on Profile Page.',
                ),
              ],
            ),
            style: const TextStyle(),
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }
}
