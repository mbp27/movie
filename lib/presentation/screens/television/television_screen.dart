import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart' hide Banner;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/config.dart';
import 'package:movie/helpers/utils.dart';
import 'package:movie/logic/blocs/television_on_the_air/television_on_the_air_bloc.dart';
import 'package:movie/logic/blocs/television_popular/television_popular_bloc.dart';
import 'package:movie/presentation/components/banner.dart';
import 'package:movie/presentation/components/banner_loading.dart';
import 'package:movie/presentation/components/custom_app_bar.dart';
import 'package:movie/presentation/components/custom_shimmer.dart';
import 'package:movie/presentation/components/poster.dart';
import 'package:movie/presentation/components/poster_loading.dart';
import 'package:movie/presentation/screens/television_detail/television_detail_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TelevisionScreen extends StatefulWidget {
  const TelevisionScreen({super.key});

  @override
  State<TelevisionScreen> createState() => _TelevisionScreenState();
}

class _TelevisionScreenState extends State<TelevisionScreen>
    with AutomaticKeepAliveClientMixin {
  late Completer<void> _refreshCompleter;

  void _loadTelevisionOnTheAir() {
    context.read<TelevisionOnTheAirBloc>().add(TelevisionOnTheAirLoaded());
    _refreshCompleter = Completer<void>();
  }

  void _loadTelevisionPopular() {
    context.read<TelevisionPopularBloc>().add(TelevisionPopularLoaded());
    _refreshCompleter = Completer<void>();
  }

  Future<void> _onRefresh() async {
    _loadTelevisionOnTheAir();
    _loadTelevisionPopular();
    return _refreshCompleter.future;
  }

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    _loadTelevisionOnTheAir();
    _loadTelevisionPopular();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: CustomAppBar(title: const Text('TV Shows')),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const _OnTheAir(),
              _buildPopular(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

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
        BlocConsumer<TelevisionPopularBloc, TelevisionPopularState>(
          listener: (context, state) {
            if (state is TelevisionPopularLoadFailure) {
              ScaffoldMessenger.of(context)
                ..clearSnackBars()
                ..showSnackBar(
                  SnackBar(
                    content: Text('${state.error}'),
                    duration: const Duration(seconds: 3),
                  ),
                );
            }
            if (state is! TelevisionPopularLoadInProgress) {
              _refreshCompleter.complete();
              _refreshCompleter = Completer();
            }
          },
          builder: (context, state) {
            if (state is TelevisionPopularLoadSuccess) {
              if (state.televisions.isNotEmpty) {
                return SizedBox(
                  height: Utils.size(context).width / 1.8,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 8.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: state.televisions.length,
                    itemBuilder: (context, index) {
                      final television = state.televisions[index];
                      final title = '${television.name}';
                      final imageUrl =
                          '${Config.originalImageUrl}/${television.posterPath}';
                      final voteAverage = television.voteAverage ?? 0;

                      return Poster(
                        title: title,
                        imageUrl: imageUrl,
                        voteAverage: voteAverage,
                        onTap: () => Navigator.of(context).pushNamed(
                          TelevisionDetailScreen.routeName,
                          arguments: TelevisionDetailScreenArguments(
                              television: television),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const AspectRatio(
                  aspectRatio: 2.0,
                  child: Center(child: Text('There are no popular tv shows')),
                );
              }
            } else if (state is TelevisionPopularLoadFailure) {
              return AspectRatio(
                aspectRatio: 2.0,
                child: GestureDetector(
                  onTap: _loadTelevisionPopular,
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

class _OnTheAir extends StatefulWidget {
  const _OnTheAir();

  @override
  State<_OnTheAir> createState() => __OnTheAirState();
}

class __OnTheAirState extends State<_OnTheAir> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'On The Air',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        BlocConsumer<TelevisionOnTheAirBloc, TelevisionOnTheAirState>(
          listener: (context, state) {
            if (state is TelevisionOnTheAirLoadFailure) {
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
            if (state is TelevisionOnTheAirLoadSuccess) {
              if (state.televisions.isNotEmpty) {
                final count = state.televisions.length > 10
                    ? 10
                    : state.televisions.length;

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: CarouselSlider.builder(
                        itemCount: count,
                        itemBuilder: (context, index, realIndex) {
                          final television = state.televisions[index];
                          final title = '${television.name}';
                          final imageUrl = television
                                      .backdropPath?.isNotEmpty ??
                                  false
                              ? '${Config.originalImageUrl}/${television.backdropPath}'
                              : null;

                          return Banner(
                            title: title,
                            imageUrl: imageUrl,
                            onTap: () => Navigator.of(context).pushNamed(
                              TelevisionDetailScreen.routeName,
                              arguments: TelevisionDetailScreenArguments(
                                  television: television),
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
                  child: Center(child: Text('There are no on air tv shows')),
                );
              }
            } else if (state is TelevisionOnTheAirLoadFailure) {
              return AspectRatio(
                aspectRatio: 2.0,
                child: GestureDetector(
                  onTap: () => context
                      .read<TelevisionOnTheAirBloc>()
                      .add(TelevisionOnTheAirLoaded()),
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
