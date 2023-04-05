import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/domain/entities/movie_entity.dart';
import 'package:movies_app/presentation/bloc/movies/now_playing/now_playing_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/movies/popular/popular_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/movies/top_rated/top_rated_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/movies/upcoming/upcoming_movies_bloc.dart';
import 'package:movies_app/presentation/cubit/tab_selected_cubit.dart';
import 'package:movies_app/presentation/pages/movies/now_playing_movies_page.dart';
import 'package:movies_app/presentation/pages/movies/popular_movies_page.dart';
import 'package:movies_app/presentation/pages/movies/search_movies_page.dart';
import 'package:movies_app/presentation/pages/movies/top_rated_movies_page.dart';
import 'package:movies_app/presentation/pages/movies/upcoming_movies_page.dart';
import 'package:movies_app/presentation/widgets/movies/movies_number.dart';
import 'package:movies_app/presentation/widgets/movies/search_textfield.dart';
import 'package:movies_app/utils/constant.dart';
import 'package:movies_app/utils/state_util.dart';
import 'package:movies_app/injection.dart' as di;

class MoviesListPage extends StatelessWidget {
  const MoviesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List menus = ["Now Playing", "Top Rated", "Upcoming", "Popular"];
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.locator<TabSelectedCubit>(),
        ),
        BlocProvider(
          create: (context) => di.locator<PopularMoviesBloc>()
            ..add(const GetPopularMoviesEvent()),
        ),
        BlocProvider(
          create: (context) => di.locator<NowPlayingMoviesBloc>()
            ..add(const GetNowPlayingMoviesEvent()),
        ),
        BlocProvider(
          create: (context) => di.locator<TopRatedMoviesBloc>()
            ..add(const GetTopRatedMoviesEvent()),
        ),
        BlocProvider(
          create: (context) => di.locator<UpcomingMoviesBloc>()
            ..add(const GetUpcomingMoviesEvent()),
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
                  Get.to(page: const SearchMoviesPage());
                },
              ),
              kVerticalSpace(10.0),
              BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
                builder: (context, state) {
                  if (state is PopularMoviesLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularMoviesHasDataState) {
                    return SizedBox(
                      height: 250.0,
                      child: ListView.builder(
                        itemCount: state.result.length,
                        scrollDirection: Axis.horizontal,
                        physics: const ScrollPhysics(),
                        itemBuilder: (context, index) {
                          final MovieEntity movie = state.result[index];
                          return MoviesNumber(
                            movies: movie,
                            number: index + 1,
                          );
                        },
                      ),
                    );
                  } else if (state is PopularMoviesErrorState) {
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
              BlocBuilder<TabSelectedCubit, int>(
                builder: (context, state) {
                  return IndexedStack(
                    index: state,
                    children: [
                      Visibility(
                        visible: state == 0,
                        child: const NowPlayingMoviesPage(),
                      ),
                      Visibility(
                        visible: state == 1,
                        child: const TopRatedMoviesPage(),
                      ),
                      Visibility(
                        visible: state == 2,
                        child: const UpcomingMoviesPage(),
                      ),
                      Visibility(
                        visible: state == 3,
                        child: const PopularMoviesPage(),
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
