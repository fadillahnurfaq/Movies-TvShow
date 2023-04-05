import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/presentation/cubit/main_navigation_cubit.dart';
import 'package:movies_app/presentation/pages/movies/movies_list_page.dart';
import 'package:movies_app/presentation/pages/people/popular_people_list_page.dart';
import 'package:movies_app/presentation/pages/tv_series/tv_series_list_page.dart';
import 'package:movies_app/presentation/pages/watchlist_page.dart';
import 'package:movies_app/utils/constant.dart';

class MainNavigationPage extends StatelessWidget {
  const MainNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    const List<BottomNavigationBarItem> _bottomNavbarItems = [
      BottomNavigationBarItem(
        icon: Icon(Icons.movie_outlined),
        label: 'Movies',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.live_tv_outlined),
        label: 'TV Series',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'People',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.bookmark_border),
        label: 'Watchlist',
      ),
    ];

    final List<Widget> _listWidget = [
      const MoviesListPage(),
      const TvSeriesListPage(),
      const PopularPeopleListPage(),
      const WatchListPage(),
    ];

    return BlocBuilder<MainNavigationCubit, int>(
      builder: (context, state) {
        return Scaffold(
          body: _listWidget[state],
          bottomNavigationBar: Container(
            height: 80.0,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: kBlueColor,
                ),
              ),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: _bottomNavbarItems,
              selectedItemColor: kBlueColor,
              unselectedItemColor: kGreyColor,
              currentIndex: state,
              onTap: (value) {
                context.read<MainNavigationCubit>().onBottomNavTapped(value);
              },
            ),
          ),
        );
      },
    );
  }
}
