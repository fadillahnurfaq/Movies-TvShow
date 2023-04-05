import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/presentation/bloc/movies/watchlist/watchlist_movie_bloc.dart';
import 'package:movies_app/presentation/widgets/movies/watchlist_movie_content.dart';
import 'package:movies_app/utils/constant.dart';

import '../../../domain/entities/movie_entity.dart';
import '../../../utils/utils.dart';

class WatchlistMoviesPage extends StatefulWidget {
  const WatchlistMoviesPage({super.key});

  @override
  State<WatchlistMoviesPage> createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    context.read<WatchlistMovieBloc>().add(const GetWatchlistMovieEvent());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistMovieBloc>().add(const GetWatchlistMovieEvent());
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 16.0,
          left: 8.0,
          right: 8.0,
          bottom: 8.0,
        ),
        child: BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
          builder: (context, state) {
            if (state is WatchlistMovieLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistMovieHasDataState) {
              return ListView.builder(
                itemCount: state.result.length,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  final MovieEntity movie = state.result[index];
                  return WatchlistMovieContent(movie: movie);
                },
              );
            } else if (state is WatchlistMovieErrorState) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is WatchlistMovieEmptyState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/empty2.png"),
                    const SizedBox(height: 10.0),
                    Text(
                      'There Is No Movie Yet!',
                      style: kHeading6,
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'Find your movie by Type title,\ncategories, years, etc ',
                      textAlign: TextAlign.center,
                      style: kBodyText.copyWith(color: kGreyBoldColor),
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
