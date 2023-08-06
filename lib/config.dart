abstract class Config {
  static late String _environment;

  static Future<void> initialize(String environment) async {
    _environment = environment;
  }

  static String get environment => _environment;

  static String get appName => const String.fromEnvironment('appName');

  static String get baseUrl => const String.fromEnvironment('baseUrl');

  static String get versionApi => const String.fromEnvironment('versionApi');

  static String get apiKey => const String.fromEnvironment('apiKey');

  static String get defaultLanguage => 'en-US';

  static String get originalImageUrl => 'https://image.tmdb.org/t/p/original';
}
