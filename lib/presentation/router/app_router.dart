import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/data/repositories/movie_repository.dart';
import 'package:movie/data/repositories/television_repository.dart';
import 'package:movie/logic/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:movie/logic/blocs/movie_review/movie_review_bloc.dart';
import 'package:movie/logic/blocs/television_detail/television_detail_bloc.dart';
import 'package:movie/logic/blocs/television_review/television_review_bloc.dart';
import 'package:movie/presentation/screens/about/about_screen.dart';
import 'package:movie/presentation/screens/main/main_screen.dart';
import 'package:movie/presentation/screens/movie_detail/movie_detail_screen.dart';
import 'package:movie/presentation/screens/not_found/not_found_screen.dart';
import 'package:movie/presentation/screens/splash/splash_screen.dart';
import 'package:movie/presentation/screens/television_detail/television_detail_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    try {
      switch (routeSettings.name) {
        case SplashScreen.routeName:
          return MaterialPageRoute(
            builder: (context) => const SplashScreen(),
          );
        case MainScreen.routeName:
          return MaterialPageRoute(
            builder: (context) => const MainScreen(),
          );
        case MovieDetailScreen.routeName:
          final arguments = routeSettings.arguments;
          if (arguments is! MovieDetailScreenArguments) {
            throw 'Please using arguments MovieDetailScreenArguments';
          }
          return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider<MovieDetailBloc>(
                  create: (context) => MovieDetailBloc(
                    movieRepository: context.read<MovieRepository>(),
                  ),
                ),
                BlocProvider<MovieReviewBloc>(
                  create: (context) => MovieReviewBloc(
                    movieRepository: context.read<MovieRepository>(),
                  ),
                ),
              ],
              child: MovieDetailScreen(movie: arguments.movie),
            ),
          );
        case TelevisionDetailScreen.routeName:
          final arguments = routeSettings.arguments;
          if (arguments is! TelevisionDetailScreenArguments) {
            throw 'Please using arguments TelevisionDetailScreenArguments';
          }
          return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider<TelevisionDetailBloc>(
                  create: (context) => TelevisionDetailBloc(
                    televisionRepository: context.read<TelevisionRepository>(),
                  ),
                ),
                BlocProvider<TelevisionReviewBloc>(
                  create: (context) => TelevisionReviewBloc(
                    televisionRepository: context.read<TelevisionRepository>(),
                  ),
                ),
              ],
              child: TelevisionDetailScreen(television: arguments.television),
            ),
          );
        case AboutScreen.routeName:
          return MaterialPageRoute(
            builder: (context) => const AboutScreen(),
          );
        default:
          return MaterialPageRoute(
            builder: (context) => const NotFoundScreen(),
          );
      }
    } catch (e) {
      return MaterialPageRoute(
        builder: (context) => const NotFoundScreen(),
      );
    }
  }
}
