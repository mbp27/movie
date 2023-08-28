import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/logic/cubits/theme/theme_cubit.dart';

import '../../../helper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  initHydratedStorage();

  group('ThemeCubit', () {
    late ThemeCubit themeCubit;

    setUp(() {
      themeCubit = ThemeCubit();
    });

    tearDown(() {
      themeCubit.close();
    });

    test('initial state is correct', () {
      expect(themeCubit.state, ThemeMode.light);
    });

    group('toJson/fromJson', () {
      test('work properly', () {
        expect(
          themeCubit.fromJson(themeCubit.toJson(themeCubit.state)),
          themeCubit.state,
        );
      });
    });

    group('onToggleTheme', () {
      blocTest<ThemeCubit, ThemeMode>(
        'emits correct themeMode for ThemeMode.light',
        build: () => themeCubit,
        act: (cubit) => cubit.onToggleTheme(themeMode: ThemeMode.light),
        expect: () => <ThemeMode>[ThemeMode.light],
      );

      blocTest<ThemeCubit, ThemeMode>(
        'emits correct themeMode for ThemeMode.dark',
        build: () => themeCubit,
        act: (cubit) => cubit.onToggleTheme(themeMode: ThemeMode.dark),
        expect: () => <ThemeMode>[ThemeMode.dark],
      );
    });
  });
}
