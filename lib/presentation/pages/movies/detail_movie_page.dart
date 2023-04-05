import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/domain/entities/movie_detail_entity.dart';
import 'package:movies_app/presentation/bloc/movies/cast/cast_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/movies/detail/detail_movies_bloc.dart';
import 'package:movies_app/presentation/cubit/movies/tab_detail_movie_cubit.dart';
import 'package:movies_app/presentation/widgets/movies/cast_movie_content.dart';
import 'package:movies_app/presentation/widgets/movies/detail_movie_content.dart';
import 'package:movies_app/presentation/widgets/movies/detail_row_content.dart';
import 'package:movies_app/utils/state_enum.dart';
import 'package:movies_app/utils/state_util.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies_app/injection.dart' as di;

import '../../../utils/constant.dart';

class DetailMoviePage extends StatelessWidget {
  final int id;
  const DetailMoviePage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final List menus = ["About Movie", "Cast"];
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.locator<DetailMoviesBloc>()
            ..add(GetDetailMoviesEvent(id))
            ..add(LoadWatchlistStatusMovieEvent(id)),
        ),
        BlocProvider(
          create: (context) => di.locator<TabDetailMovieCubit>(),
        ),
        BlocProvider(
          create: (context) =>
              di.locator<CastMoviesBloc>()..add(GetCastMovieEvent(id)),
        ),
      ],
      child: BlocConsumer<DetailMoviesBloc, DetailMovieState>(
        listener: (context, state) {
          final message = state.watchlistMessage;
          if (message == DetailMoviesBloc.watchlistAddSuccessMessage ||
              message == DetailMoviesBloc.watchlistRemoveSuccessMessage) {
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
          final movieDetailState = state.movieDetailState;
          if (movieDetailState == RequestState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (movieDetailState == RequestState.loaded) {
            final MovieDetailEntity movie = state.movieDetail!;
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
                        context.read<DetailMoviesBloc>().add(
                              AddWatchlistMovieEvent(
                                movie,
                              ),
                            );
                      } else {
                        context.read<DetailMoviesBloc>().add(
                              RemoveFromWatchlistMovieEvent(
                                movie,
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
                  DetailMovieContent(
                    movie: movie,
                  ),
                  kVerticalSpace(90.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DetailRowContent(
                          icon: FontAwesomeIcons.calendarWeek,
                          title: movie.releaseDate == ""
                              ? "Empty"
                              : movie.releaseDate.substring(0, 4),
                        ),
                        Container(
                          height: 16.0,
                          width: 1.0,
                          color: kGreyBoldColor,
                        ),
                        DetailRowContent(
                          icon: FontAwesomeIcons.clock,
                          title: "${movie.runtime} Minutes",
                        ),
                        Container(
                          height: 16.0,
                          width: 1.0,
                          color: kGreyBoldColor,
                        ),
                        DetailRowContent(
                          icon: FontAwesomeIcons.ticket,
                          title: movie.genres.isNotEmpty
                              ? movie.genres[0].name
                              : "Empty",
                        ),
                      ],
                    ),
                  ),
                  kVerticalSpace(25.0),
                  BlocBuilder<TabDetailMovieCubit, int>(
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
                                      .read<TabDetailMovieCubit>()
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
                  BlocBuilder<TabDetailMovieCubit, int>(
                    builder: (context, tabState) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: IndexedStack(
                          index: tabState,
                          children: [
                            Visibility(
                              visible: tabState == 0,
                              child: Text(movie.overview),
                            ),
                            Visibility(
                              visible: tabState == 1,
                              child: const CastMovieContent(),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          } else if (movieDetailState == RequestState.error) {
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
