import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/data/repositories/movie_repository.dart';
import 'package:movie/data/repositories/television_repository.dart';
import 'package:movie/logic/blocs/movie_now_playing/movie_now_playing_bloc.dart';
import 'package:movie/logic/blocs/movie_popular/movie_popular_bloc.dart';
import 'package:movie/logic/blocs/movie_upcoming/movie_upcoming_bloc.dart';
import 'package:movie/logic/blocs/television_on_the_air/television_on_the_air_bloc.dart';
import 'package:movie/logic/blocs/television_popular/television_popular_bloc.dart';
import 'package:movie/logic/cubits/theme/theme_cubit.dart';

class MockStorage extends Mock implements Storage {}

class MockMovieRepository extends Mock implements MovieRepository {}

class MockTelevisionRepository extends Mock implements TelevisionRepository {}

class MockMovieNowPlayingBloc
    extends MockBloc<MovieNowPlayingEvent, MovieNowPlayingState>
    implements MovieNowPlayingBloc {}

class MockMovieUpcomingBloc
    extends MockBloc<MovieUpcomingEvent, MovieUpcomingState>
    implements MovieUpcomingBloc {}

class MockMoviePopularBloc
    extends MockBloc<MoviePopularEvent, MoviePopularState>
    implements MoviePopularBloc {}

class MockTelevisionOnTheAirBloc
    extends MockBloc<TelevisionOnTheAirEvent, TelevisionOnTheAirState>
    implements TelevisionOnTheAirBloc {}

class MockTelevisionPopularBloc
    extends MockBloc<TelevisionPopularEvent, TelevisionPopularState>
    implements TelevisionPopularBloc {}

class MockThemeCubit extends MockCubit<ThemeMode> implements ThemeCubit {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp({
    required Widget child,
    MovieRepository? movieRepository,
    TelevisionRepository? televisionRepository,
    MovieNowPlayingBloc? movieNowPlayingBloc,
    MovieUpcomingBloc? movieUpcomingBloc,
    MoviePopularBloc? moviePopularBloc,
    TelevisionOnTheAirBloc? televisionOnTheAirBloc,
    TelevisionPopularBloc? televisionPopularBloc,
    ThemeCubit? themeCubit,
  }) {
    return pumpWidget(
      MultiRepositoryProvider(
        providers: [
          if (movieRepository != null)
            RepositoryProvider<MovieRepository>.value(value: movieRepository)
          else
            RepositoryProvider<MovieRepository>(
              create: (context) => MockMovieRepository(),
            ),
          if (televisionRepository != null)
            RepositoryProvider<TelevisionRepository>.value(
                value: televisionRepository)
          else
            RepositoryProvider<TelevisionRepository>(
              create: (context) => MockTelevisionRepository(),
            ),
        ],
        child: MultiBlocProvider(
          providers: [
            if (movieNowPlayingBloc != null)
              BlocProvider<MovieNowPlayingBloc>.value(
                  value: movieNowPlayingBloc)
            else
              BlocProvider<MovieNowPlayingBloc>(
                create: (context) => MockMovieNowPlayingBloc(),
              ),
            if (movieUpcomingBloc != null)
              BlocProvider<MovieUpcomingBloc>.value(value: movieUpcomingBloc)
            else
              BlocProvider<MovieUpcomingBloc>(
                create: (context) => MockMovieUpcomingBloc(),
              ),
            if (moviePopularBloc != null)
              BlocProvider<MoviePopularBloc>.value(value: moviePopularBloc)
            else
              BlocProvider<MoviePopularBloc>(
                create: (context) => MockMoviePopularBloc(),
              ),
            if (televisionOnTheAirBloc != null)
              BlocProvider<TelevisionOnTheAirBloc>.value(
                  value: televisionOnTheAirBloc)
            else
              BlocProvider<TelevisionOnTheAirBloc>(
                create: (context) => MockTelevisionOnTheAirBloc(),
              ),
            if (televisionPopularBloc != null)
              BlocProvider<TelevisionPopularBloc>.value(
                  value: televisionPopularBloc)
            else
              BlocProvider<TelevisionPopularBloc>(
                create: (context) => MockTelevisionPopularBloc(),
              ),
            if (themeCubit != null)
              BlocProvider<ThemeCubit>.value(value: themeCubit)
            else
              BlocProvider<ThemeCubit>(
                create: (context) => MockThemeCubit(),
              ),
          ],
          child: child,
        ),
      ),
    );
  }
}

late Storage hydratedStorage;

void initHydratedStorage() {
  hydratedStorage = MockStorage();
  when(
    () => hydratedStorage.write(any(), any<dynamic>()),
  ).thenAnswer((_) async {});
  HydratedBloc.storage = hydratedStorage;
}
