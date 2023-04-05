import 'package:flutter/material.dart';
import 'package:movies_app/presentation/pages/movies/watch_list_movie_page.dart';
import 'package:movies_app/presentation/pages/tv_series/watch_list_tv_series_page.dart';
import 'package:movies_app/utils/constant.dart';

class WatchListPage extends StatefulWidget {
  const WatchListPage({super.key});

  @override
  State<WatchListPage> createState() => _WatchListPageState();
}

class _WatchListPageState extends State<WatchListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _listTabs.length,
      vsync: this,
      initialIndex: 0,
    );
  }

  final List<Widget> _listTabs = [
    const Text('Movies'),
    const Text(
      'TV Series',
    ),
  ];

  final List<Widget> _listWidget = [
    const WatchlistMoviesPage(),
    const WatchListTvSeriesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Watch List"),
        bottom: TabBar(
          labelPadding: const EdgeInsets.all(16.0),
          tabs: _listTabs,
          controller: _tabController,
          indicatorColor: kBlueColor,
        ),
      ),
      body: TabBarView(controller: _tabController, children: _listWidget),
    );
  }
}
