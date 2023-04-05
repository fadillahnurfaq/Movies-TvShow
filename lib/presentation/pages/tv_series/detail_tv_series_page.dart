import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/domain/entities/tv_series/season_entity.dart';
import 'package:movies_app/domain/entities/tv_series/tv_series_detail_entity.dart';
import 'package:movies_app/presentation/bloc/tv_series/detail/detail_tv_series_bloc.dart';

import 'package:movies_app/presentation/cubit/tv_series/tab_detail_tv_series_cubit.dart';
import 'package:movies_app/presentation/widgets/movies/detail_row_content.dart';
import 'package:movies_app/presentation/widgets/tv_series/detail_tv_series_content.dart';
import 'package:movies_app/presentation/widgets/tv_series/season_tv_series_content.dart';
import 'package:movies_app/utils/state_enum.dart';
import 'package:movies_app/utils/state_util.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies_app/injection.dart' as di;

import '../../../utils/constant.dart';

class DetailTvSeriesPage extends StatelessWidget {
  final int id;
  const DetailTvSeriesPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final List menus = ["About Movie", "Season"];
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.locator<DetailTvSeriesBloc>()
            ..add(GetDetailTvSeriesEvent(id))
            ..add(LoadWatchlistStatusMovieEvent(id)),
        ),
        BlocProvider(
          create: (context) => di.locator<TabDetailTvSeriesCubit>(),
        ),
      ],
      child: BlocConsumer<DetailTvSeriesBloc, DetailTvSeriesState>(
        listener: (context, state) {
          final message = state.watchlistMessage;
          if (message == DetailTvSeriesBloc.watchlistAddSuccessMessage ||
              message == DetailTvSeriesBloc.watchlistRemoveSuccessMessage) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
              ),
            );
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(message),
                );
              },
            );
          }
        },
        listenWhen: (oldState, newState) {
          return oldState.watchlistMessage != newState.watchlistMessage &&
              newState.watchlistMessage != '';
        },
        builder: (context, state) {
          final tvSeriesDetailState = state.tvSeriesDetailState;
          if (tvSeriesDetailState == RequestState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (tvSeriesDetailState == RequestState.loaded) {
            final TvSeriesDetailEntity tvSeries = state.tvSeriesDetail!;
            final List<SeasonEntity> seasons = tvSeries.seasons;
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  splashRadius: 30.0,
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                title: const Text("Detail"),
                actions: [
                  IconButton(
                    splashRadius: 30.0,
                    onPressed: () {
                      if (!state.isAddedToWatchlist) {
                        context.read<DetailTvSeriesBloc>().add(
                              AddWatchlistTvSeriesEvent(
                                tvSeries,
                              ),
                            );
                      } else {
                        context.read<DetailTvSeriesBloc>().add(
                              RemoveFromWatchlistTvSeriesEvent(
                                tvSeries,
                              ),
                            );
                      }
                    },
                    icon: state.isAddedToWatchlist
                        ? const Icon(Icons.bookmark)
                        : const Icon(Icons.bookmark_outline),
                  ),
                ],
              ),
              body: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  DetailTvSeriesContent(
                    tvSeries: tvSeries,
                  ),
                  kVerticalSpace(90.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DetailRowContent(
                          icon: FontAwesomeIcons.calendarWeek,
                          title: tvSeries.firstAirDate == ""
                              ? "Empty"
                              : tvSeries.firstAirDate.substring(0, 4),
                        ),
                        Container(
                          height: 16.0,
                          width: 1.0,
                          color: kGreyBoldColor,
                        ),
                        DetailRowContent(
                          icon: Icons.movie,
                          title: "${tvSeries.numberOfEpisodes} Episode",
                        ),
                        Container(
                          height: 16.0,
                          width: 1.0,
                          color: kGreyBoldColor,
                        ),
                        DetailRowContent(
                          icon: FontAwesomeIcons.ticket,
                          title: tvSeries.genres.isNotEmpty
                              ? tvSeries.genres[0].name
                              : "Empty",
                        ),
                      ],
                    ),
                  ),
                  kVerticalSpace(25.0),
                  BlocBuilder<TabDetailTvSeriesCubit, int>(
                    builder: (context, tabState) {
                      return Row(
                        children: List.generate(
                          menus.length,
                          (index) {
                            var menu = menus[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: GestureDetector(
                                onTap: () {
                                  context
                                      .read<TabDetailTvSeriesCubit>()
                                      .selectedTab(index);
                                },
                                child: Column(
                                  children: [
                                    Text(menu),
                                    kVerticalSpace(10.0),
                                    tabState == index
                                        ? Container(
                                            height: 4.0,
                                            width: 90.0,
                                            decoration: const BoxDecoration(
                                              color: kGreySoftColor,
                                            ),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  kVerticalSpace(20.0),
                  BlocBuilder<TabDetailTvSeriesCubit, int>(
                    builder: (context, tabState) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: IndexedStack(
                          index: tabState,
                          children: [
                            Visibility(
                              visible: tabState == 0,
                              child: Text(tvSeries.overview),
                            ),
                            Visibility(
                                visible: tabState == 1,
                                child: SeasonTvSeriesContent(seasons: seasons)),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          } else if (tvSeriesDetailState == RequestState.error) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
