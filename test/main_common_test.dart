import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/logic/blocs/movie_now_playing/movie_now_playing_bloc.dart';
import 'package:movie/logic/blocs/movie_popular/movie_popular_bloc.dart';
import 'package:movie/logic/blocs/movie_upcoming/movie_upcoming_bloc.dart';
import 'package:movie/logic/cubits/theme/theme_cubit.dart';
import 'package:movie/main_common.dart';
import 'package:movie/presentation/screens/main/main_screen.dart';
import 'package:movie/presentation/screens/splash/splash_screen.dart';

import 'helper.dart';

void main() {
  initHydratedStorage();

  const themeMode = ThemeMode.light;

  group('MyApp', () {
    testWidgets('renders MyAppView', (tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle(const Duration(seconds: 3));
      expect(find.byType(MyAppView), findsOneWidget);
    });
  });

  group('MyAppView', () {
    late ThemeCubit themeCubit;
    late MovieNowPlayingBloc movieNowPlayingBloc;
    late MovieUpcomingBloc movieUpcomingBloc;
    late MoviePopularBloc moviePopularBloc;

    setUp(() {
      themeCubit = MockThemeCubit();
      movieNowPlayingBloc = MockMovieNowPlayingBloc();
      movieUpcomingBloc = MockMovieUpcomingBloc();
      moviePopularBloc = MockMoviePopularBloc();
    });

    testWidgets('renders MyAppView', (tester) async {
      when(() => themeCubit.state).thenReturn(themeMode);
      when(() => movieNowPlayingBloc.state)
          .thenReturn(const MovieNowPlayingState());
      when(() => movieUpcomingBloc.state)
          .thenReturn(const MovieUpcomingState());
      when(() => moviePopularBloc.state).thenReturn(const MoviePopularState());
      await tester.pumpApp(
        themeCubit: themeCubit,
        movieNowPlayingBloc: movieNowPlayingBloc,
        movieUpcomingBloc: movieUpcomingBloc,
        moviePopularBloc: moviePopularBloc,
        child: const MyAppView(),
      );
      expect(find.byType(SplashScreen), findsOneWidget);
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpApp(
        themeCubit: themeCubit,
        movieNowPlayingBloc: movieNowPlayingBloc,
        movieUpcomingBloc: movieUpcomingBloc,
        moviePopularBloc: moviePopularBloc,
        child: const MaterialApp(home: MainScreen()),
      );
      expect(find.byType(MainScreen), findsOneWidget);
    });

    testWidgets('has correct theme mode', (tester) async {
      when(() => themeCubit.state).thenReturn(themeMode);
      when(() => movieNowPlayingBloc.state)
          .thenReturn(const MovieNowPlayingState());
      when(() => movieUpcomingBloc.state)
          .thenReturn(const MovieUpcomingState());
      when(() => moviePopularBloc.state).thenReturn(const MoviePopularState());
      await tester.pumpApp(
        themeCubit: themeCubit,
        movieNowPlayingBloc: movieNowPlayingBloc,
        movieUpcomingBloc: movieUpcomingBloc,
        moviePopularBloc: moviePopularBloc,
        child: const MyAppView(),
      );
      await tester.pump(const Duration(seconds: 3));
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.themeMode, themeMode);
    });
  });
}
