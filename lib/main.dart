import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_app/presentation/bloc/movies/watchlist/watchlist_movie_bloc.dart';
import 'package:movies_app/presentation/bloc/tv_series/watchlist/watchlist_tv_series_bloc.dart';
import 'package:movies_app/presentation/cubit/main_navigation_cubit.dart';
import 'package:movies_app/presentation/pages/splash_page.dart';
import 'package:movies_app/utils/constant.dart';
import 'package:movies_app/utils/http_ssl_painning.dart';
import 'package:movies_app/utils/state_util.dart';
import 'package:movies_app/utils/utils.dart';
import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HttpSSLPinning.init();
  di.init();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.locator<MainNavigationCubit>(),
        ),
        BlocProvider(
          create: (context) => di.locator<WatchlistMovieBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<WatchlistTvSeriesBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Movies App',
        home: const SplashPage(),
        debugShowCheckedModeBanner: false,
        navigatorObservers: [routeObserver],
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: kPrimaryColor,
          primaryColor: kPrimaryColor,
          textTheme: kTextTheme,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            titleTextStyle: kHeading6,
          ),
          colorScheme: ColorScheme.fromSwatch(accentColor: kBlueColor),
        ),
        navigatorKey: Get.navigatorKey,
      ),
    );
  }
}
