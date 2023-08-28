import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/logic/blocs/movie_now_playing/movie_now_playing_bloc.dart';
import 'package:movie/logic/blocs/movie_popular/movie_popular_bloc.dart';
import 'package:movie/logic/blocs/movie_upcoming/movie_upcoming_bloc.dart';
import 'package:movie/logic/blocs/television_on_the_air/television_on_the_air_bloc.dart';
import 'package:movie/logic/blocs/television_popular/television_popular_bloc.dart';
import 'package:movie/presentation/screens/main/main_screen.dart';
import 'package:movie/presentation/screens/movie/movie_screen.dart';
import 'package:movie/presentation/screens/profile/profile_screen.dart';
import 'package:movie/presentation/screens/television/television_screen.dart';

import '../../helper.dart';

void main() {
  initHydratedStorage();

  late MovieNowPlayingBloc movieNowPlayingBloc;
  late MovieUpcomingBloc movieUpcomingBloc;
  late MoviePopularBloc moviePopularBloc;
  late TelevisionOnTheAirBloc televisionOnTheAirBloc;
  late TelevisionPopularBloc televisionPopularBloc;

  setUp(() {
    movieNowPlayingBloc = MockMovieNowPlayingBloc();
    movieUpcomingBloc = MockMovieUpcomingBloc();
    moviePopularBloc = MockMoviePopularBloc();
    televisionOnTheAirBloc = MockTelevisionOnTheAirBloc();
    televisionPopularBloc = MockTelevisionPopularBloc();
  });

  group('MainScreen', () {
    testWidgets('renders PageView', (tester) async {
      when(() => movieNowPlayingBloc.state)
          .thenReturn(const MovieNowPlayingState());
      when(() => movieUpcomingBloc.state)
          .thenReturn(const MovieUpcomingState());
      when(() => moviePopularBloc.state).thenReturn(const MoviePopularState());
      await tester.pumpApp(
        movieNowPlayingBloc: movieNowPlayingBloc,
        movieUpcomingBloc: movieUpcomingBloc,
        moviePopularBloc: moviePopularBloc,
        child: const MaterialApp(home: MainScreen()),
      );
      expect(find.byType(PageView), findsWidgets);
    });

    testWidgets('renders BottomNavigationBar', (tester) async {
      when(() => movieNowPlayingBloc.state)
          .thenReturn(const MovieNowPlayingState());
      when(() => movieUpcomingBloc.state)
          .thenReturn(const MovieUpcomingState());
      when(() => moviePopularBloc.state).thenReturn(const MoviePopularState());
      await tester.pumpApp(
        movieNowPlayingBloc: movieNowPlayingBloc,
        movieUpcomingBloc: movieUpcomingBloc,
        moviePopularBloc: moviePopularBloc,
        child: const MaterialApp(home: MainScreen()),
      );
      expect(find.byType(BottomNavigationBar), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(BottomNavigationBar),
          matching: find.text(MovieScreen.title),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(BottomNavigationBar),
          matching: find.text(TelevisionScreen.title),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(BottomNavigationBar),
          matching: find.text(ProfileScreen.title),
        ),
        findsOneWidget,
      );
    });

    testWidgets('renders MovieScreen', (tester) async {
      when(() => movieNowPlayingBloc.state)
          .thenReturn(const MovieNowPlayingState());
      when(() => movieUpcomingBloc.state)
          .thenReturn(const MovieUpcomingState());
      when(() => moviePopularBloc.state).thenReturn(const MoviePopularState());
      await tester.pumpApp(
        movieNowPlayingBloc: movieNowPlayingBloc,
        movieUpcomingBloc: movieUpcomingBloc,
        moviePopularBloc: moviePopularBloc,
        child: const MaterialApp(home: MovieScreen()),
      );
      expect(find.byType(MovieScreen), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(AppBar),
          matching: find.text(MovieScreen.title),
        ),
        findsOneWidget,
      );
    });

    testWidgets('renders TelevisionScreen', (tester) async {
      when(() => televisionOnTheAirBloc.state)
          .thenReturn(const TelevisionOnTheAirState());
      when(() => televisionPopularBloc.state)
          .thenReturn(const TelevisionPopularState());
      await tester.pumpApp(
        televisionOnTheAirBloc: televisionOnTheAirBloc,
        televisionPopularBloc: televisionPopularBloc,
        child: const MaterialApp(home: TelevisionScreen()),
      );
      expect(find.byType(TelevisionScreen), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(AppBar),
          matching: find.text(TelevisionScreen.title),
        ),
        findsOneWidget,
      );
    });

    testWidgets('renders ProfileScreen', (tester) async {
      await tester.pumpApp(
        child: const MaterialApp(home: ProfileScreen()),
      );
      expect(find.byType(ProfileScreen), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(AppBar),
          matching: find.text(ProfileScreen.title),
        ),
        findsOneWidget,
      );
    });
  });
}
