import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:movie/config.dart';
import 'package:movie/data/repositories/movie_repository.dart';
import 'package:movie/data/repositories/television_repository.dart';
import 'package:movie/logic/blocs/movie_now_playing/movie_now_playing_bloc.dart';
import 'package:movie/logic/blocs/movie_popular/movie_popular_bloc.dart';
import 'package:movie/logic/blocs/movie_upcoming/movie_upcoming_bloc.dart';
import 'package:movie/logic/blocs/television_on_the_air/television_on_the_air_bloc.dart';
import 'package:movie/logic/blocs/television_popular/television_popular_bloc.dart';
import 'package:movie/logic/cubits/theme/theme_cubit.dart';
import 'package:movie/presentation/components/custom_scroll_behavior.dart';
import 'package:movie/presentation/designs/app_theme.dart';
import 'package:movie/presentation/router/app_router.dart';
import 'package:movie/presentation/screens/splash/splash_screen.dart';
import 'package:path_provider/path_provider.dart';

Future<void> mainCommon(String environment) async {
  WidgetsFlutterBinding.ensureInitialized();
  PaintingBinding.instance.imageCache.maximumSizeBytes = 1000 << 20;
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<MovieRepository>(
          create: (context) => MovieRepository(),
        ),
        RepositoryProvider<TelevisionRepository>(
          create: (context) => TelevisionRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<MovieNowPlayingBloc>(
            create: (context) => MovieNowPlayingBloc(
              movieRepository: context.read<MovieRepository>(),
            ),
          ),
          BlocProvider<MovieUpcomingBloc>(
            create: (context) => MovieUpcomingBloc(
              movieRepository: context.read<MovieRepository>(),
            ),
          ),
          BlocProvider<MoviePopularBloc>(
            create: (context) => MoviePopularBloc(
              movieRepository: context.read<MovieRepository>(),
            ),
          ),
          BlocProvider<TelevisionOnTheAirBloc>(
            create: (context) => TelevisionOnTheAirBloc(
              televisionRepository: context.read<TelevisionRepository>(),
            ),
          ),
          BlocProvider<TelevisionPopularBloc>(
            create: (context) => TelevisionPopularBloc(
              televisionRepository: context.read<TelevisionRepository>(),
            ),
          ),
          BlocProvider<ThemeCubit>(
            create: (context) => ThemeCubit(),
          ),
        ],
        child: Builder(
          builder: (context) {
            final themeMode = context.select((ThemeCubit cubit) => cubit.state);

            return MaterialApp(
              // darkTheme: ThemeData(
              //   appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
              //   brightness: Brightness.dark,
              //   fontFamily: FontFamily.archivo,
              //   primaryColor: AppColor.primary,
              //   primarySwatch: MaterialColorGenerator.from(AppColor.primary),
              //   scaffoldBackgroundColor: Colors.black,
              //   bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              //     backgroundColor: Colors.black,
              //     selectedItemColor: AppColor.primary,
              //   ),
              //   useMaterial3: false,
              // ),
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: themeMode,
              debugShowCheckedModeBanner: false,
              title: Config.appName,
              onGenerateRoute: AppRouter().onGenerateRoute,
              initialRoute: SplashScreen.routeName,
              builder: (context, child) => ScrollConfiguration(
                behavior: CustomScrollBehavior(),
                child: child ?? Container(),
              ),
            );
          },
        ),
      ),
    );
  }
}
