import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/domain/entities/tv_series/tv_series_detail_entity.dart';

import '../../../utils/constant.dart';

class DetailTvSeriesContent extends StatelessWidget {
  final TvSeriesDetailEntity tvSeries;
  const DetailTvSeriesContent({super.key, required this.tvSeries});

  @override
  Widget build(BuildContext context) {
    const double top = 210 - 120 / 2;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 210.0,
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
                  imageUrl: tvSeries.backdropPath == null
                      ? "https://i.ibb.co/TWLKGMY/No-Image-Available.jpg"
                      : "$baseImageUrl${tvSeries.backdropPath}",
                  fit: BoxFit.cover,
                  height: 210.0,
                  width: double.infinity,
                  placeholder: (_, __) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  height: 24.0,
                  width: 54.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: const Color(0xFF252836).withOpacity(.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star_outline,
                        size: 20.0,
                        color: kOrangeColor,
                      ),
                      Text(
                        "${tvSeries.voteAverage.floorToDouble()}",
                        style: const TextStyle(color: kOrangeColor),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: top,
          left: 30,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 120.0,
                    width: 95.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: kGreySoftColor,
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: tvSeries.posterPath == null
                            ? "https://i.ibb.co/TWLKGMY/No-Image-Available.jpg"
                            : "$baseImageUrl${tvSeries.posterPath}",
                        fit: BoxFit.cover,
                        height: 120.0,
                        width: 95.0,
                        placeholder: (_, __) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  kHorizontalSpace(10.0),
                  SizedBox(
                    width: 250.0,
                    child: Text(
                      tvSeries.name,
                      style: kHeading5,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
