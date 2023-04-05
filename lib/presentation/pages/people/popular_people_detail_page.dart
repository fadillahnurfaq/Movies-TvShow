import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies_app/domain/entities/known_for_entity.dart';
import 'package:movies_app/domain/entities/popular_people_entity.dart';
import 'package:movies_app/presentation/widgets/people/knownfor_people_content.dart';
import 'package:movies_app/utils/state_util.dart';

import '../../../utils/constant.dart';
import '../../widgets/movies/detail_row_content.dart';

class PopularPeopleDetailPage extends StatelessWidget {
  final PopularPeopleEntity popularPeople;
  const PopularPeopleDetailPage({super.key, required this.popularPeople});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 30.0,
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("Detail"),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: kGreySoftColor,
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(16.0),
              ),
              child: CachedNetworkImage(
                imageUrl: popularPeople.profilePath == null
                    ? "https://i.ibb.co/TWLKGMY/No-Image-Available.jpg"
                    : "$baseImageUrl${popularPeople.profilePath}",
                fit: BoxFit.cover,
                placeholder: (_, __) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          kVerticalSpace(20.0),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  popularPeople.name ?? "Empty data",
                  style: kHeading5,
                ),
                kVerticalSpace(10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DetailRowContent(
                      icon: FontAwesomeIcons.users,
                      title: "${popularPeople.popularity}",
                    ),
                    DetailRowContent(
                      icon: FontAwesomeIcons.ticket,
                      title: "${popularPeople.knownForDepartment}",
                    ),
                  ],
                ),
                kVerticalSpace(20.0),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: popularPeople.knownFor!.length,
                  itemBuilder: (context, index) {
                    final KnownForEntity knownFor =
                        popularPeople.knownFor![index];
                    return KnownForContent(knownFor: knownFor);
                  },
                ),
              ],
            ),
          ),
          kVerticalSpace(20.0),
        ],
      ),
    );
  }
}
