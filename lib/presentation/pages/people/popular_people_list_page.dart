import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/domain/entities/popular_people_entity.dart';
import 'package:movies_app/injection.dart' as di;
import 'package:movies_app/presentation/bloc/people/popular/popular_people_bloc.dart';
import 'package:movies_app/presentation/pages/people/popular_people_detail_page.dart';

import '../../../utils/constant.dart';
import '../../../utils/state_util.dart';

class PopularPeopleListPage extends StatelessWidget {
  const PopularPeopleListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          di.locator<PopularPeopleBloc>()..add(const GetPopularPeopleEvent()),
      child: BlocBuilder<PopularPeopleBloc, PopularPeopleState>(
        builder: (context, state) {
          if (state is PopularPeopleLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PopularPeopleHasDataState) {
            return Scaffold(
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(
                    top: 40.0, left: 20.0, right: 20.0, bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Popular People",
                      style: kHeading5,
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      itemCount: state.result.length,
                      physics: const ScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        crossAxisCount: 3,
                        childAspectRatio: 10 / 17,
                      ),
                      itemBuilder: (context, index) {
                        final PopularPeopleEntity popularPeople =
                            state.result[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 150.0,
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
                                      imageUrl: popularPeople.profilePath ==
                                              null
                                          ? "https://i.ibb.co/TWLKGMY/No-Image-Available.jpg"
                                          : "$baseImageUrl${popularPeople.profilePath}",
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
                                            page: PopularPeopleDetailPage(
                                              popularPeople: popularPeople,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Text(
                              "${popularPeople.name}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          } else if (state is PopularPeopleErrorState) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
