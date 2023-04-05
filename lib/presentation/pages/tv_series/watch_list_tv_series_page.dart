import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/domain/entities/tv_series/tv_series_entity.dart';
import 'package:movies_app/presentation/widgets/tv_series/watch_list_tv_series_content.dart';

import '../../../utils/constant.dart';
import '../../../utils/utils.dart';
import '../../bloc/tv_series/watchlist/watchlist_tv_series_bloc.dart';

class WatchListTvSeriesPage extends StatefulWidget {
  const WatchListTvSeriesPage({super.key});

  @override
  State<WatchListTvSeriesPage> createState() => _WatchListTvSeriesPageState();
}

class _WatchListTvSeriesPageState extends State<WatchListTvSeriesPage>
    with RouteAware {
  @override
  void initState() {
    context
        .read<WatchlistTvSeriesBloc>()
        .add(const GetWatchlistTvSeriesEvent());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context
        .read<WatchlistTvSeriesBloc>()
        .add(const GetWatchlistTvSeriesEvent());
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
        child: BlocBuilder<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
          builder: (context, state) {
            if (state is WatchlistTvSeriesLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistTvSeriesHasDataState) {
              return ListView.builder(
                itemCount: state.result.length,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  final TvSeriesEntity tvSeries = state.result[index];

                  return WatchListTvSeriesContent(tvSeries: tvSeries);
                },
              );
            } else if (state is WatchlistTvSeriesErrorState) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is WatchlistTvSeriesEmptyState) {
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
