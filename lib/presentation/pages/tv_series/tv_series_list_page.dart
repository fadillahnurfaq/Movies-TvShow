import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/domain/entities/tv_series/tv_series_entity.dart';
import 'package:movies_app/presentation/bloc/tv_series/on_the_air/on_the_air_tv_series_bloc.dart';
import 'package:movies_app/presentation/bloc/tv_series/popular/popular_tv_series_bloc.dart';
import 'package:movies_app/presentation/bloc/tv_series/top_rated/top_rated_tv_series_bloc.dart';
import 'package:movies_app/presentation/cubit/tab_selected_cubit.dart';
import 'package:movies_app/presentation/pages/tv_series/airing_today_page.dart';
import 'package:movies_app/presentation/pages/tv_series/on_the_air_page.dart';
import 'package:movies_app/presentation/pages/tv_series/popular_tv_series_page.dart';
import 'package:movies_app/presentation/pages/tv_series/search_tv_series_page.dart';
import 'package:movies_app/presentation/pages/tv_series/top_rated_tv_series_page.dart';
import 'package:movies_app/presentation/widgets/movies/search_textfield.dart';
import 'package:movies_app/presentation/widgets/tv_series/tv_series_number.dart';
import 'package:movies_app/utils/constant.dart';
import 'package:movies_app/utils/state_util.dart';
import 'package:movies_app/injection.dart' as di;

import '../../bloc/tv_series/airing_today/airing_today_tv_series_bloc.dart';

class TvSeriesListPage extends StatelessWidget {
  const TvSeriesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List menus = ["Popular", "Top Rated", "On The Air", "Airing Today"];
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.locator<TabSelectedCubit>(),
        ),
        BlocProvider(
          create: (context) => di.locator<AiringTodayTvSeriesBloc>()
            ..add(const GetAiringTodayTvSeriesEvent()),
        ),
        BlocProvider(
          create: (context) => di.locator<PopularTvSeriesBloc>()
            ..add(const GetPopularTvSeriesEvent()),
        ),
        BlocProvider(
          create: (context) => di.locator<TopRatedTvSeriesBloc>()
            ..add(const GetTopRatedTvSeriesEvent()),
        ),
        BlocProvider(
          create: (context) => di.locator<OnTheAirTvSeriesBloc>()
            ..add(const GetOnTheAirTvSeriesEvent()),
        ),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kVerticalSpace(10.0),
              Text(
                "What do you want to watch?",
                style: kHeading6,
              ),
              kVerticalSpace(15.0),
              SearchTextField(
                onTap: () {
                  Get.to(page: const SearchTvSeriesPage());
                },
              ),
              kVerticalSpace(10.0),
              BlocBuilder<AiringTodayTvSeriesBloc, AiringTodayTvSeriesState>(
                builder: (context, state) {
                  if (state is AiringTodayTvSeriesLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is AiringTodayTvSeriesHasDataState) {
                    return SizedBox(
                      height: 250.0,
                      child: ListView.builder(
                        itemCount: state.result.length,
                        scrollDirection: Axis.horizontal,
                        physics: const ScrollPhysics(),
                        itemBuilder: (context, index) {
                          final TvSeriesEntity tvSeries = state.result[index];
                          return TvSeriesNumber(
                            tvSeries: tvSeries,
                            number: index + 1,
                          );
                        },
                      ),
                    );
                  } else if (state is AiringTodayTvSeriesErrorState) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              kVerticalSpace(10.0),
              BlocBuilder<TabSelectedCubit, int>(
                builder: (context, state) {
                  return Row(
                    children: List.generate(
                      menus.length,
                      (index) {
                        var menu = menus[index];
                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              context
                                  .read<TabSelectedCubit>()
                                  .selectedTab(index);
                            },
                            child: Column(
                              children: [
                                Text(menu),
                                kVerticalSpace(10.0),
                                state == index
                                    ? Container(
                                        height: 4.0,
                                        width: 80.0,
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
              BlocBuilder<TabSelectedCubit, int>(
                builder: (context, state) {
                  return IndexedStack(
                    index: state,
                    children: [
                      Visibility(
                        visible: state == 0,
                        child: const PopularTvSeriesPage(),
                      ),
                      Visibility(
                        visible: state == 1,
                        child: const TopRatedTvSeriesPage(),
                      ),
                      Visibility(
                        visible: state == 2,
                        child: const OnTheAirPage(),
                      ),
                      Visibility(
                        visible: state == 3,
                        child: const AiringTodayTvSeriesPage(),
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
