import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart' hide Banner;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/config.dart';
import 'package:movie/helpers/utils.dart';
import 'package:movie/logic/blocs/movie_now_playing/movie_now_playing_bloc.dart';
import 'package:movie/logic/blocs/movie_popular/movie_popular_bloc.dart';
import 'package:movie/logic/blocs/movie_upcoming/movie_upcoming_bloc.dart';
import 'package:movie/presentation/components/banner.dart';
import 'package:movie/presentation/components/banner_loading.dart';
import 'package:movie/presentation/components/custom_app_bar.dart';
import 'package:movie/presentation/components/custom_shimmer.dart';
import 'package:movie/presentation/components/poster.dart';
import 'package:movie/presentation/components/poster_loading.dart';
import 'package:movie/presentation/screens/movie_detail/movie_detail_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen>
    with AutomaticKeepAliveClientMixin {
  late Completer<void> _refreshCompleter;

  void _loadMovieNowPlaying() {
    context.read<MovieNowPlayingBloc>().add(MovieNowPlayingLoaded());
    _refreshCompleter = Completer<void>();
  }

  void _loadMovieUpcoming() {
    context.read<MovieUpcomingBloc>().add(MovieUpcomingLoaded());
    _refreshCompleter = Completer<void>();
  }

  void _loadMoviePopular() {
    context.read<MoviePopularBloc>().add(MoviePopularLoaded());
    _refreshCompleter = Completer<void>();
  }

  Future<void> _onRefresh() async {
    _loadMovieNowPlaying();
    _loadMovieUpcoming();
    _loadMoviePopular();
    return _refreshCompleter.future;
  }

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    _loadMovieNowPlaying();
    _loadMovieUpcoming();
    _loadMoviePopular();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: CustomAppBar(title: const Text('Movies')),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const _NowPlaying(),
              _buildUpcoming(),
              _buildPopular(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget _buildUpcoming() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Upcoming',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        BlocConsumer<MovieUpcomingBloc, MovieUpcomingState>(
          listener: (context, state) {
            if (state is MovieUpcomingLoadFailure) {
              ScaffoldMessenger.of(context)
                ..clearSnackBars()
                ..showSnackBar(
                  SnackBar(
                    content: Text('${state.error}'),
                    duration: const Duration(seconds: 3),
                  ),
                );
            }
            if (state is! MovieUpcomingLoadInProgress) {
              _refreshCompleter.complete();
              _refreshCompleter = Completer();
            }
          },
          builder: (context, state) {
            if (state is MovieUpcomingLoadSuccess) {
              if (state.movies.isNotEmpty) {
                return SizedBox(
                  height: Utils.size(context).width / 1.8,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 8.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: state.movies.length,
                    itemBuilder: (context, index) {
                      final movie = state.movies[index];
                      final title = '${movie.title}';
                      final imageUrl =
                          '${Config.originalImageUrl}/${movie.posterPath}';
                      final voteAverage = movie.voteAverage ?? 0;

                      return Poster(
                        title: title,
                        imageUrl: imageUrl,
                        voteAverage: voteAverage,
                        onTap: () => Navigator.of(context).pushNamed(
                          MovieDetailScreen.routeName,
                          arguments: MovieDetailScreenArguments(movie: movie),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const AspectRatio(
                  aspectRatio: 2.0,
                  child: Center(child: Text('There are no upcoming movies')),
                );
              }
            } else if (state is MovieUpcomingLoadFailure) {
              return AspectRatio(
                aspectRatio: 2.0,
                child: GestureDetector(
                  onTap: _loadMovieUpcoming,
                  child: const Center(
                    child: CircleAvatar(child: Icon(Icons.refresh)),
                  ),
                ),
              );
            } else {
              return SizedBox(
                height: Utils.size(context).width / 1.8,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (context, index) => const PosterLoading(),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildPopular() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Popular',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        BlocConsumer<MoviePopularBloc, MoviePopularState>(
          listener: (context, state) {
            if (state is MoviePopularLoadFailure) {
              ScaffoldMessenger.of(context)
                ..clearSnackBars()
                ..showSnackBar(
                  SnackBar(
                    content: Text('${state.error}'),
                    duration: const Duration(seconds: 3),
                  ),
                );
            }
            if (state is! MoviePopularLoadInProgress) {
              _refreshCompleter.complete();
              _refreshCompleter = Completer();
            }
          },
          builder: (context, state) {
            if (state is MoviePopularLoadSuccess) {
              if (state.movies.isNotEmpty) {
                return SizedBox(
                  height: Utils.size(context).width / 1.8,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 8.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: state.movies.length,
                    itemBuilder: (context, index) {
                      final movie = state.movies[index];
                      final title = '${movie.title}';
                      final imageUrl =
                          '${Config.originalImageUrl}/${movie.posterPath}';
                      final voteAverage = movie.voteAverage ?? 0;

                      return Poster(
                        title: title,
                        imageUrl: imageUrl,
                        voteAverage: voteAverage,
                        onTap: () => Navigator.of(context).pushNamed(
                          MovieDetailScreen.routeName,
                          arguments: MovieDetailScreenArguments(movie: movie),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const AspectRatio(
                  aspectRatio: 2.0,
                  child: Center(child: Text('There are no popular movies')),
                );
              }
            } else if (state is MoviePopularLoadFailure) {
              return AspectRatio(
                aspectRatio: 2.0,
                child: GestureDetector(
                  onTap: _loadMoviePopular,
                  child: const Center(
                    child: CircleAvatar(child: Icon(Icons.refresh)),
                  ),
                ),
              );
            } else {
              return SizedBox(
                height: Utils.size(context).width / 1.8,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (context, index) => const PosterLoading(),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

class _NowPlaying extends StatefulWidget {
  const _NowPlaying();

  @override
  State<_NowPlaying> createState() => __NowPlayingState();
}

class __NowPlayingState extends State<_NowPlaying> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Now Playing',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        BlocConsumer<MovieNowPlayingBloc, MovieNowPlayingState>(
          listener: (context, state) {
            if (state is MovieNowPlayingLoadFailure) {
              ScaffoldMessenger.of(context)
                ..clearSnackBars()
                ..showSnackBar(
                  SnackBar(
                    content: Text('${state.error}'),
                    duration: const Duration(seconds: 3),
                  ),
                );
            }
          },
          builder: (context, state) {
            if (state is MovieNowPlayingLoadSuccess) {
              if (state.movies.isNotEmpty) {
                final count =
                    state.movies.length > 10 ? 10 : state.movies.length;

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: CarouselSlider.builder(
                        itemCount: count,
                        itemBuilder: (context, index, realIndex) {
                          final movie = state.movies[index];
                          final title = '${movie.title}';
                          final imageUrl =
                              '${Config.originalImageUrl}/${movie.backdropPath}';

                          return Banner(
                            title: title,
                            imageUrl: imageUrl,
                            onTap: () => Navigator.of(context).pushNamed(
                              MovieDetailScreen.routeName,
                              arguments:
                                  MovieDetailScreenArguments(movie: movie),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          enlargeCenterPage: true,
                          autoPlayInterval: const Duration(seconds: 10),
                          viewportFraction:
                              Utils.orientation(context) == Orientation.portrait
                                  ? 0.915
                                  : 0.955,
                          aspectRatio: 2.0,
                          enableInfiniteScroll: true,
                          autoPlay: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          },
                        ),
                      ),
                    ),
                    Center(
                      child: AnimatedSmoothIndicator(
                        count: count,
                        effect: ExpandingDotsEffect(
                          activeDotColor: Theme.of(context).primaryColor,
                          dotColor: Colors.grey.shade500,
                          expansionFactor: 2,
                          radius: 10,
                          spacing: 5,
                          dotHeight: 7,
                          dotWidth: 7,
                        ),
                        activeIndex: _current,
                      ),
                    ),
                  ],
                );
              } else {
                return const AspectRatio(
                  aspectRatio: 2.0,
                  child: Center(child: Text('There are no played movies')),
                );
              }
            } else if (state is MovieNowPlayingLoadFailure) {
              return AspectRatio(
                aspectRatio: 2.0,
                child: GestureDetector(
                  onTap: () => context
                      .read<MovieNowPlayingBloc>()
                      .add(MovieNowPlayingLoaded()),
                  child: const Center(
                    child: CircleAvatar(child: Icon(Icons.refresh)),
                  ),
                ),
              );
            } else {
              return CustomShimmer(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: CarouselSlider.builder(
                        itemCount: 6,
                        itemBuilder: (context, index, realIndex) =>
                            const BannerLoading(),
                        options: CarouselOptions(
                          enlargeCenterPage: true,
                          viewportFraction: 0.92,
                          aspectRatio: 2.0,
                          enableInfiniteScroll: false,
                          autoPlay: false,
                          scrollPhysics: const NeverScrollableScrollPhysics(),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        height: 7.0,
                        width: 100.0,
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
