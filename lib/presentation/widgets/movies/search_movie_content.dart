import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies_app/domain/entities/movie_entity.dart';
import 'package:movies_app/presentation/pages/movies/detail_movie_page.dart';
import 'package:movies_app/utils/state_util.dart';

import '../../../utils/constant.dart';
import 'detail_row_content.dart';

class SearchMovieContent extends StatelessWidget {
  final MovieEntity movie;
  const SearchMovieContent({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 120.0,
                width: 95.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: kGreySoftColor),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: movie.posterPath == null
                        ? "https://i.ibb.co/TWLKGMY/No-Image-Available.jpg"
                        : "$baseImageUrl${movie.posterPath}",
                    fit: BoxFit.cover,
                    width: 95.0,
                    height: 120.0,
                    placeholder: (_, __) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              kHorizontalSpace(10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title ?? "Empty",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kHeading6,
                    ),
                    kVerticalSpace(10.0),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_outline,
                          size: 20.0,
                          color: kOrangeColor,
                        ),
                        Text(
                          "${movie.voteAverage?.floorToDouble() ?? "Empty"}",
                          style: const TextStyle(color: kOrangeColor),
                        )
                      ],
                    ),
                    DetailRowContent(
                      icon: FontAwesomeIcons.calendarWeek,
                      title: movie.releaseDate == null
                          ? "Empty"
                          : movie.releaseDate == ""
                              ? "Empty"
                              : movie.releaseDate!.substring(0, 4),
                      iconColor: Colors.white,
                      textColor: Colors.white,
                    ),
                    DetailRowContent(
                      icon: FontAwesomeIcons.checkToSlot,
                      title: "${movie.voteCount ?? "Empty"}",
                      iconColor: Colors.white,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              )
            ],
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
  }
}
