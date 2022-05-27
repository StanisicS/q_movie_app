import 'package:cached_network_image/cached_network_image.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:q_movie_app/controllers/base_controller.dart';
import 'package:q_movie_app/data/models/movies_list.dart';
import 'package:q_movie_app/utils/assets.dart';
import 'package:q_movie_app/utils/spacing.dart';
import 'package:q_movie_app/utils/app_colors.dart';

class MovieListTile extends StatelessWidget {
  final String backdropPath;
  final String title;
  final Widget icon;
  final BaseController controller = Get.find();
  final double voteAverage;
  final Movie movieItem;
  final void Function() onTap;

  MovieListTile({
    Key? key,
    required this.backdropPath,
    required this.title,
    required this.voteAverage,
    required this.movieItem,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: SizedBox(
            width: 100,
            child: FancyShimmerImage(
              imageUrl: 'https://image.tmdb.org/t/p/w500/$backdropPath',
              errorWidget: const Icon(Icons.error),
              boxFit: BoxFit.cover,
              height: 100,
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: onTap,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: Get.textTheme.subtitle1,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          Svgs.star,
                        ),
                        Text(
                          " ${voteAverage.toString()} / 10 IMDb",
                          maxLines: 1,
                          style: Get.textTheme.caption,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: Get.width,
                height: 25,
                margin: paddingTop12,
                child: ListView.separated(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    controller: controller.scrollController,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, top: 3, bottom: 4),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                            color: AppColors.primary.withOpacity(0.2)),
                        child: Text(
                          controller.genres
                              .firstWhere((item) =>
                                  item.id == movieItem.genreIds[index])
                              .name,
                          style: Get.textTheme.caption,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          width: 4,
                        ),
                    itemCount: movieItem.genreIds.length),
              )
            ],
          ),
        ),
        icon
      ],
    );
  }
}
