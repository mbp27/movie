import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart' hide Banner;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:movie/config.dart';
import 'package:movie/data/models/genre.dart';
import 'package:movie/data/models/television.dart';
import 'package:movie/helpers/utils.dart';
import 'package:movie/logic/blocs/television_detail/television_detail_bloc.dart';
import 'package:movie/logic/blocs/television_review/television_review_bloc.dart';
import 'package:movie/presentation/components/custom_shimmer.dart';
import 'package:movie/presentation/components/image_error.dart';
import 'package:movie/presentation/components/loading.dart';
import 'package:movie/presentation/components/no_image.dart';
import 'package:movie/presentation/components/rating_bar.dart';
import 'package:movie/presentation/components/review_loading_widget.dart';
import 'package:movie/presentation/components/review_widget.dart';

class TelevisionDetailScreenArguments {
  final Television television;

  TelevisionDetailScreenArguments({
    required this.television,
  });
}

class TelevisionDetailScreen extends StatefulWidget {
  const TelevisionDetailScreen({
    Key? key,
    required this.television,
  }) : super(key: key);

  static const String routeName = '/television_detail';

  final Television television;

  @override
  State<TelevisionDetailScreen> createState() => _TelevisionDetailScreenState();
}

class _TelevisionDetailScreenState extends State<TelevisionDetailScreen> {
  late Completer<void> _refreshCompleter;
  double _imageHeight = 0;
  bool _isPinned = false;
  final ScrollController _scrollController = ScrollController();

  void _loadTelevisionDetail() {
    context
        .read<TelevisionDetailBloc>()
        .add(TelevisionDetailLoaded(television: widget.television));
    _refreshCompleter = Completer<void>();
  }

  void _loadTelevisionReview() {
    context
        .read<TelevisionReviewBloc>()
        .add(TelevisionReviewLoaded(television: widget.television));
    _refreshCompleter = Completer<void>();
  }

  Future<void> _onRefresh() async {
    _loadTelevisionDetail();
    return _refreshCompleter.future;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _imageHeight = Utils.size(context).width / 2;
      },
    );
    _refreshCompleter = Completer<void>();
    _scrollController.addListener(() {
      if (!_isPinned &&
          _scrollController.hasClients &&
          _scrollController.offset > _imageHeight / 2) {
        if (_isPinned == false) {
          setState(() {
            _isPinned = true;
          });
        }
      } else if (_isPinned &&
          _scrollController.hasClients &&
          _scrollController.offset < _imageHeight / 2) {
        if (_isPinned == true) {
          setState(() {
            _isPinned = false;
          });
        }
      }
    });
    _loadTelevisionDetail();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backButtonBackgroundColor =
        _isPinned ? Colors.transparent : Colors.black12;
    final backButtonForegroundColor = _isPinned
        ? Theme.of(context).appBarTheme.foregroundColor
        : Colors.white;
    final backgroundColor = Theme.of(context).focusColor;

    return OrientationBuilder(
      builder: (context, orientation) {
        _imageHeight = Utils.size(context).width / 2;

        return Scaffold(
          appBar: AppBar(
            title: _isPinned ? Text('${widget.television.name}') : null,
            backgroundColor: !_isPinned ? Colors.transparent : null,
            leading: CircleAvatar(
              backgroundColor: backButtonBackgroundColor,
              foregroundColor: backButtonForegroundColor,
              child: const BackButton(),
            ),
          ),
          extendBodyBehindAppBar: true,
          body: BlocConsumer<TelevisionDetailBloc, TelevisionDetailState>(
            listener: (context, state) {
              if (state is TelevisionDetailLoadFailure) {
                ScaffoldMessenger.of(context)
                  ..clearSnackBars()
                  ..showSnackBar(
                    SnackBar(
                      content: Text('${state.error}'),
                      duration: const Duration(seconds: 3),
                    ),
                  );
              }
              if (state is TelevisionDetailLoadSuccess) {
                _loadTelevisionReview();
              }
              if (state is! TelevisionDetailLoadInProgress) {
                _refreshCompleter.complete();
                _refreshCompleter = Completer();
              }
            },
            builder: (context, state) {
              if (state is TelevisionDetailLoadSuccess) {
                final television = state.television;
                final title = '${television.name}';
                final backdropErrorSize = Utils.size(context).width / 6;
                final backdropUrl = television.backdropPath?.isNotEmpty ?? false
                    ? '${Config.originalImageUrl}/${television.backdropPath}'
                    : null;
                final posterUrl = television.posterPath?.isNotEmpty ?? false
                    ? '${Config.originalImageUrl}/${television.posterPath}'
                    : null;
                final firstAirDate = television.firstAirDate;
                final voteAverage = television.voteAverage ?? 0;
                final status = '${television.status}';
                final numberOfEpisodes = television.numberOfEpisodes;
                final numberOfSeasons = television.numberOfSeasons;
                final overview = '${television.overview}';
                final genres = television.genres?.toList() ?? [];

                return RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: _scrollController,
                    child: Column(
                      children: [
                        IntrinsicHeight(
                          child: Stack(
                            clipBehavior: Clip.none,
                            fit: StackFit.expand,
                            children: [
                              Container(
                                color: backgroundColor,
                                height: _imageHeight,
                                child: Container(
                                  color: backgroundColor,
                                  child: backdropUrl != null
                                      ? FutureBuilder<File>(
                                          future:
                                              Utils.downloadImage(backdropUrl),
                                          builder: (context, snapshot) {
                                            final file = snapshot.data;
                                            if (file != null) {
                                              return Image.file(
                                                file,
                                                fit: BoxFit.fill,
                                                errorBuilder:
                                                    (context, object, error) =>
                                                        Center(
                                                  child: ImageError(
                                                    size: backdropErrorSize,
                                                  ),
                                                ),
                                              );
                                            } else {
                                              return const Center(
                                                child: Loading(),
                                              );
                                            }
                                          },
                                        )
                                      : Center(
                                          child:
                                              NoImage(size: backdropErrorSize),
                                        ),
                                ),
                              ),
                              Positioned(
                                top: _imageHeight * 0.6,
                                left: 16.0,
                                right: 16.0,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            offset: const Offset(0, 0),
                                            spreadRadius: 10,
                                            blurRadius: 20,
                                            color:
                                                Colors.black.withOpacity(0.2),
                                          )
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        child: Container(
                                          color: backgroundColor,
                                          height:
                                              Utils.size(context).width / 2.1,
                                          width: Utils.size(context).width / 3,
                                          child: Container(
                                            color: backgroundColor,
                                            child: posterUrl != null
                                                ? FutureBuilder<File>(
                                                    future: Utils.downloadImage(
                                                        posterUrl),
                                                    builder:
                                                        (context, snapshot) {
                                                      final file =
                                                          snapshot.data;
                                                      if (file != null) {
                                                        return Image.file(
                                                          file,
                                                          fit: BoxFit.fill,
                                                          errorBuilder:
                                                              (context, object,
                                                                      error) =>
                                                                  const Center(
                                                            child: ImageError(),
                                                          ),
                                                        );
                                                      } else {
                                                        return const Center(
                                                          child: Loading(),
                                                        );
                                                      }
                                                    },
                                                  )
                                                : const Center(
                                                    child: NoImage()),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16.0),
                                    Flexible(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              offset: const Offset(0, 0),
                                              spreadRadius: 10,
                                              blurRadius: 20,
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                            )
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                title,
                                                maxLines: 5,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 2.0),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                RatingBar(
                                                  rating: voteAverage,
                                                  size: 16.0,
                                                ),
                                                const SizedBox(width: 4.0),
                                                Text(
                                                  voteAverage.toString(),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 4.0),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  firstAirDate != null
                                                      ? DateFormat('yyyy-MM-dd')
                                                          .format(firstAirDate)
                                                      : '-',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(width: 6.0),
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2.0),
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 4.0,
                                                      vertical: 2.0,
                                                    ),
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    child: Text(
                                                      status,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 4.0),
                                            Flexible(
                                              child: Text(
                                                '$numberOfEpisodes Episodes',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 4.0),
                                            Flexible(
                                              child: Text(
                                                '$numberOfSeasons Seasons',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                            16.0,
                            (_imageHeight * 0.6) + 8.0,
                            16.0,
                            16.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildOverview(overview),
                              const SizedBox(height: 16.0),
                              _buildGenres(genres),
                              const SizedBox(height: 16.0),
                              _buildReviews(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (state is TelevisionDetailLoadFailure) {
                return Center(
                  child: GestureDetector(
                    onTap: _loadTelevisionDetail,
                    child: const CircleAvatar(child: Icon(Icons.refresh)),
                  ),
                );
              } else {
                return _buildLoading();
              }
            },
          ),
        );
      },
    );
  }

  Widget _buildOverview(String overview) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Overview',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          overview,
          style: const TextStyle(fontSize: 12.0),
        ),
      ],
    );
  }

  Widget _buildGenres(List<Genre> genres) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Genres',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        Wrap(
          runSpacing: 6.0,
          spacing: 6.0,
          children: genres
              .map((e) => ClipRRect(
                    borderRadius: BorderRadius.circular(2.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4.0,
                        vertical: 2.0,
                      ),
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        '${e.name}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildReviews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Reviews',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        BlocConsumer<TelevisionReviewBloc, TelevisionReviewState>(
          listener: (context, state) {
            if (state is TelevisionReviewLoadFailure) {
              ScaffoldMessenger.of(context)
                ..clearSnackBars()
                ..showSnackBar(
                  SnackBar(
                    content: Text('${state.error}'),
                    duration: const Duration(seconds: 3),
                  ),
                );
            }
            if (state is! TelevisionReviewLoadInProgress) {
              _refreshCompleter.complete();
              _refreshCompleter = Completer();
            }
          },
          builder: (context, state) {
            if (state is TelevisionReviewLoadSuccess) {
              if (state.reviews.isNotEmpty) {
                final count =
                    state.reviews.length > 3 ? 3 : state.reviews.length;
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16.0),
                  itemCount: count,
                  itemBuilder: (context, index) {
                    final review = state.reviews[index];
                    return ReviewWidget(review: review);
                  },
                );
              } else {
                return const AspectRatio(
                  aspectRatio: 4.0,
                  child: Center(child: Text('There are no reviews')),
                );
              }
            } else if (state is TelevisionReviewLoadFailure) {
              return AspectRatio(
                aspectRatio: 4.0,
                child: GestureDetector(
                  onTap: _loadTelevisionReview,
                  child: const Center(
                    child: CircleAvatar(child: Icon(Icons.refresh)),
                  ),
                ),
              );
            } else {
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16.0),
                itemCount: 3,
                itemBuilder: (context, index) => const ReviewLoadingWidget(),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildOverviewLoading() {
    return CustomShimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              color: Colors.grey,
              height: 16.0,
              width: 70.0,
            ),
          ),
          const SizedBox(height: 12.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [null, null, null, Utils.size(context).width / 2]
                .map((e) => Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          color: Colors.grey,
                          height: 12.0,
                          width: e,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildGenresLoading() {
    return CustomShimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              color: Colors.grey,
              height: 16.0,
              width: 60.0,
            ),
          ),
          const SizedBox(height: 12.0),
          Wrap(
            runSpacing: 6.0,
            spacing: 6.0,
            children: [1, 2, 3]
                .map((e) => ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        color: Colors.grey,
                        height: 16.0,
                        width: 40.0,
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return SingleChildScrollView(
      child: Column(
        children: [
          IntrinsicHeight(
            child: Stack(
              clipBehavior: Clip.none,
              fit: StackFit.expand,
              children: [
                CustomShimmer(
                  child: SizedBox(
                    height: _imageHeight,
                    child: Container(color: Colors.grey),
                  ),
                ),
                Positioned(
                  top: _imageHeight * 0.6,
                  left: 16.0,
                  right: 16.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 0),
                              spreadRadius: 10,
                              blurRadius: 20,
                              color: Colors.black.withOpacity(0.2),
                            )
                          ],
                        ),
                        child: CustomShimmer(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6.0),
                            child: SizedBox(
                              height: Utils.size(context).width / 2.1,
                              width: Utils.size(context).width / 3,
                              child: Container(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                spreadRadius: 10,
                                blurRadius: 20,
                                color: Colors.black.withOpacity(0.2),
                              )
                            ],
                          ),
                          child: CustomShimmer(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Container(
                                    color: Colors.grey,
                                    height: 20.0,
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Container(
                                        color: Colors.grey,
                                        height: 16.0,
                                        width: 80.0,
                                      ),
                                    ),
                                    const SizedBox(width: 8.0),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Container(
                                        color: Colors.grey,
                                        height: 18.0,
                                        width: 40.0,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8.0),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Container(
                                        color: Colors.grey,
                                        height: 12.0,
                                        width: 60.0,
                                      ),
                                    ),
                                    const SizedBox(width: 6.0),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Container(
                                        color: Colors.grey,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0,
                                          vertical: 2.0,
                                        ),
                                        height: 12.0,
                                        width: 60.0,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8.0),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Container(
                                    color: Colors.grey,
                                    height: 12.0,
                                    width: 60.0,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Container(
                                    color: Colors.grey,
                                    height: 12.0,
                                    width: 50.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(
              16.0,
              (_imageHeight * 0.6) + 8.0,
              16.0,
              16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildOverviewLoading(),
                const SizedBox(height: 16.0),
                _buildGenresLoading(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
