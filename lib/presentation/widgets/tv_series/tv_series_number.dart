import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/domain/entities/tv_series/tv_series_entity.dart';
import 'package:movies_app/presentation/pages/tv_series/detail_tv_series_page.dart';
import 'package:movies_app/utils/state_util.dart';

import '../../../utils/constant.dart';

class TvSeriesNumber extends StatelessWidget {
  final int number;
  final TvSeriesEntity tvSeries;
  const TvSeriesNumber(
      {super.key, required this.number, required this.tvSeries});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.5),
          child: Container(
            height: 210.0,
            width: 144.61,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Colors.white.withOpacity(.2),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(16.0),
              ),
              child: CachedNetworkImage(
                imageUrl: tvSeries.posterPath == null
                    ? "https://i.ibb.co/TWLKGMY/No-Image-Available.jpg"
                    : "$baseImageUrl${tvSeries.posterPath}",
                height: MediaQuery.of(context).size.height * .4,
                fit: BoxFit.cover,
                placeholder: (_, __) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ),
        Positioned(
          top: 150.5,
          left: 20.0,
          child: Stack(
            children: [
              FittedBox(
                child: Text(
                  "$number",
                  style: TextStyle(
                    fontSize: 80.0,
                    fontWeight: FontWeight.w600,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1
                      ..color = kBlueColor,
                  ),
                ),
              ),
              Text(
                "$number",
                style: const TextStyle(
                  fontSize: 80.0,
                  color: kPrimaryColor,
                ),
              )
            ],
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
                    page: DetailTvSeriesPage(
                  id: tvSeries.id,
                ));
              },
            ),
          ),
        )
      ],
    );
  }
}
