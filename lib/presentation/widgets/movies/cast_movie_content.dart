import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/domain/entities/cast_entity.dart';
import 'package:movies_app/presentation/bloc/movies/cast/cast_movies_bloc.dart';

import '../../../utils/constant.dart';

class CastMovieContent extends StatelessWidget {
  const CastMovieContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CastMoviesBloc, CastMoviesState>(
      builder: (context, state) {
        if (state is CastMoviesLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CastMoviesHasDataState) {
          return GridView.builder(
            shrinkWrap: true,
            itemCount: state.result.length,
            physics: const ScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              final CastEntity cast = state.result[index];
              return Column(
                children: [
                  CircleAvatar(
                    maxRadius: 60.0,
                    backgroundColor: kGreySoftColor,
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: cast.profilePath == null
                            ? "https://i.ibb.co/TWLKGMY/No-Image-Available.jpg"
                            : "$baseImageUrl${cast.profilePath}",
                        fit: BoxFit.cover,
                        width: double.infinity,
                        placeholder: (_, __) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  kVerticalSpace(5.0),
                  SizedBox(
                    width: 100.0,
                    child: Text(
                      "${cast.originalName}",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              );
            },
          );
        } else if (state is CastMoviesErrorState) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is CastMoviesEmptyState) {
          return const Center(
            child: Text("Empty data"),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
