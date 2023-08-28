import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:movie/environment.dart';
import 'package:movie/main_common.dart' as app;
import 'package:movie/presentation/screens/about/about_screen.dart';
import 'package:movie/presentation/screens/main/main_screen.dart';
import 'package:movie/presentation/screens/profile/profile_screen.dart';
import 'package:movie/presentation/screens/splash/splash_screen.dart';
import 'package:movie/presentation/screens/television/television_screen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end to end test', () {
    testWidgets('initialize splash screen and UI interactions', (tester) async {
      // Run main
      await app.mainCommon(Environment.development);

      // Wait for 1 seconds to make sure everything is working
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Check if SplashScreen is visible and wait for 3 seconds
      expect(find.byType(SplashScreen), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Assuming the splash screen transitions to the main screen
      expect(find.byType(MainScreen), findsOneWidget);

      // Check if BottomNavigationBar is visible
      expect(find.byType(BottomNavigationBar), findsOneWidget);

      // Check if any TelevisionScreen.title on BottomNavigationBar
      expect(
        find.descendant(
          of: find.byType(BottomNavigationBar),
          matching: find.text(TelevisionScreen.title),
        ),
        findsOneWidget,
      );

      // Tap the BottomNavigationBarItem with TelevisionScreen.title label
      await tester.tap(find.descendant(
        of: find.byType(BottomNavigationBar),
        matching: find.text(TelevisionScreen.title),
      ));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Check if TelevisionScreen is visible
      expect(find.byType(TelevisionScreen), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(AppBar),
          matching: find.text(TelevisionScreen.title),
        ),
        findsOneWidget,
      );

      // Check if any ProfileScreen.title on BottomNavigationBar
      expect(
        find.descendant(
          of: find.byType(BottomNavigationBar),
          matching: find.text(ProfileScreen.title),
        ),
        findsOneWidget,
      );

      // Tap the BottomNavigationBarItem with ProfileScreen.title label
      await tester.tap(find.descendant(
        of: find.byType(BottomNavigationBar),
        matching: find.text(ProfileScreen.title),
      ));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Check if ProfileScreen is visible
      expect(find.byType(ProfileScreen), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(AppBar),
          matching: find.text(ProfileScreen.title),
        ),
        findsOneWidget,
      );

      // Check if current themeMode is light
      expect(find.byType(AppBar), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(AppBar),
          matching: find.byIcon(Icons.brightness_4),
        ),
        findsOneWidget,
      );

      MaterialApp materialApp =
          tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.themeMode, ThemeMode.light);

      // Tap the brightness icon and switch themeMode to dark
      await tester.tap(find.descendant(
        of: find.byType(AppBar),
        matching: find.byIcon(Icons.brightness_4),
      ));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Check if current themeMode is dark
      expect(find.byType(AppBar), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(AppBar),
          matching: find.byIcon(Icons.brightness_5),
        ),
        findsOneWidget,
      );

      materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.themeMode, ThemeMode.dark);

      // Check if any info icon on AppBar
      expect(find.byType(AppBar), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(AppBar),
          matching: find.byIcon(Icons.info_outline),
        ),
        findsOneWidget,
      );

      // Tap the info icon and transitions to the about screen
      await tester.tap(find.descendant(
        of: find.byType(AppBar),
        matching: find.byIcon(Icons.info_outline),
      ));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.byType(AboutScreen), findsOneWidget);
    });
  });
}
