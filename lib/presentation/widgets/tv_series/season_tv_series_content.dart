import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/tv_series/season_entity.dart';
import '../../../utils/constant.dart';

class SeasonTvSeriesContent extends StatelessWidget {
  final List<SeasonEntity> seasons;
  const SeasonTvSeriesContent({super.key, required this.seasons});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: seasons.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 10.0,
        crossAxisCount: 3,
      ),
      itemBuilder: (context, index) {
        final SeasonEntity season = seasons[index];
        return Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Container(
            width: 100.0,
            height: 150.0,
            decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(8.0)),
            child: Column(
              children: [
                Flexible(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: season.posterPath != null
                          ? '$baseImageUrl${season.posterPath}'
                          : 'https://i.ibb.co/TWLKGMY/No-Image-Available.jpg',
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (_, __) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      errorWidget: (_, __, error) {
                        return Container(
                          color: Colors.black26,
                          child: const Center(
                            child: Text('No Image'),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Center(
                      child: Text(
                        season.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
