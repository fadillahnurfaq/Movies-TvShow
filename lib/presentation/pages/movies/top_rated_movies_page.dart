import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/presentation/bloc/movies/top_rated/top_rated_movies_bloc.dart';

import '../../../domain/entities/movie_entity.dart';
import '../../../utils/constant.dart';
import '../../../utils/state_util.dart';
import 'detail_movie_page.dart';

class TopRatedMoviesPage extends StatelessWidget {
  const TopRatedMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
        builder: (context, state) {
      if (state is TopRatedMoviesLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is TopRatedMoviesHasDataState) {
        return GridView.builder(
          shrinkWrap: true,
          itemCount: state.result.length,
          physics: const ScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            crossAxisCount: 3,
            childAspectRatio: 10 / 13,
          ),
          itemBuilder: (context, index) {
            final MovieEntity movie = state.result[index];
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.white.withOpacity(.2),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16.0),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: movie.posterPath == null
                          ? "https://i.ibb.co/TWLKGMY/No-Image-Available.jpg"
                          : "$baseImageUrl${movie.posterPath}",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      placeholder: (_, __) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(16.0),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () {
                          Get.to(
                            page: DetailMoviePage(
                              id: movie.id,
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      } else if (state is TopRatedMoviesErrorState) {
        return Center(
          child: Text(state.message),
        );
      } else {
        return const SizedBox();
      }
    });
  }
}
