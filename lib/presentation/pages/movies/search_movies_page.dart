import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies_app/domain/entities/movie_entity.dart';
import 'package:movies_app/presentation/bloc/movies/search/search_movies_bloc.dart';
import 'package:movies_app/presentation/widgets/movies/search_movie_content.dart';

import '../../../utils/constant.dart';
import '../../../utils/state_util.dart';
import 'package:movies_app/injection.dart' as di;

class SearchMoviesPage extends StatelessWidget {
  const SearchMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.locator<SearchMoviesBloc>(),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                splashRadius: 30.0,
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              title: const Text("Search"),
              actions: [
                IconButton(
                  splashRadius: 30.0,
                  onPressed: () {},
                  icon: const Icon(FontAwesomeIcons.circleExclamation),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50.0,
                    child: TextField(
                      textInputAction: TextInputAction.search,
                      onChanged: (value) {
                        context
                            .read<SearchMoviesBloc>()
                            .add(SearchMoviesOnQueryChangedEvent(value));
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: kGreySoftColor,
                        hintText: "Search",
                        suffixIcon: const Icon(
                          Icons.search,
                          color: kGreyColor,
                        ),
                        contentPadding: const EdgeInsets.all(15.0),
                        border: _borders(),
                        enabledBorder: _borders(),
                        focusedBorder: _borders(),
                        disabledBorder: _borders(),
                      ),
                    ),
                  ),
                  kVerticalSpace(20.0),
                  BlocBuilder<SearchMoviesBloc, SearchMoviesState>(
                    builder: (context, state) {
                      if (state is SearchMoviesLoadingState) {
                        return const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (state is SearchMoviesHasDataState) {
                        return Expanded(
                          child: ListView.builder(
                            physics: const ScrollPhysics(),
                            itemCount: state.result.length,
                            itemBuilder: (context, index) {
                              final MovieEntity movie = state.result[index];
                              return SearchMovieContent(
                                movie: movie,
                              );
                            },
                          ),
                        );
                      } else if (state is SearchMoviesEmptyState) {
                        return Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/empty1.png"),
                                const SizedBox(height: 10.0),
                                Text(
                                  'we are sorry, we can\nnot find the movie :(',
                                  textAlign: TextAlign.center,
                                  style: kHeading6,
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  'Find your movie by Type title,\ncategories, years, etc ',
                                  textAlign: TextAlign.center,
                                  style:
                                      kBodyText.copyWith(color: kGreyBoldColor),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else if (state is SearchMoviesErrorState) {
                        return Expanded(
                          child: Center(
                            key: const Key('error_message'),
                            child: Text(state.message),
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  _borders() {
    return const OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(
        Radius.circular(20.0),
      ),
    );
  }
}
