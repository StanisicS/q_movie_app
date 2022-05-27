import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_movie_app/controllers/base_controller.dart';
import 'package:q_movie_app/controllers/favorites_controller.dart';
import 'package:q_movie_app/utils/assets.dart';
import 'package:q_movie_app/utils/app_colors.dart';
import 'package:q_movie_app/utils/spacing.dart';
import 'package:q_movie_app/views/widgets/header.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({Key? key}) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  BaseController controller = Get.find();
  final FavoritesController favController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        int sensitivity = 20;
        if (details.delta.dy > sensitivity || details.delta.dy < -sensitivity) {
          Navigator.of(context).pop();
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: Stack(
            children: [
              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: Get.height,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: AppColors.navBar),
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                              'https://image.tmdb.org/t/p/w500/${controller.movie!.posterPath}',
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.fitWidth,
                        ),
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Padding(
                            padding: wrapper,
                            child: Header(
                                icon: Image.asset(
                              Images.back,
                              width: 28,
                              height: 28,
                            )),
                          ),
                        ),
                      ],
                    ),
                  )),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: AppColors.background),
                  height: Get.height * 0.6,
                  child: Padding(
                    padding: wrapper,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              controller.movie!.title,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: Get.textTheme.headline2,
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                controller.movie!.isFav =
                                    !controller.movie!.isFav;

                                if (controller.movie!.isFav) {
                                  favController.favorites
                                      .add(controller.movie!);
                                  controller.movie!.isFav = true;
                                }

                                if (!controller.movie!.isFav) {
                                  favController.favorites.removeWhere(
                                      (element) =>
                                          element.id == controller.movie!.id);
                                  controller.movie!.isFav = false;
                                }
                                setState(() {});
                                controller.favorites.refresh();
                                favController.favorites.refresh();
                                controller.movies.refresh();
                              },
                              child: Container(
                                margin: const EdgeInsets.all(6.0),
                                child: Image.asset(
                                  !controller.movie!.isFav
                                      ? Images.book
                                      : Images.bookFilled,
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                              highlightColor:
                                  AppColors.primary.withOpacity(0.2),
                              splashColor: AppColors.primary.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              Images.star,
                              width: 16,
                              height: 16,
                            ),
                            Text(
                              " ${controller.movie!.voteAverage.toString()} / 10 IMDb",
                              maxLines: 1,
                              style: Get.textTheme.caption,
                            )
                          ],
                        ),
                        Container(
                          width: Get.width,
                          height: 25,
                          margin: paddingTop12,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: const EdgeInsets.only(
                                      left: 8, right: 8, top: 3, bottom: 4),
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(4)),
                                      color:
                                          AppColors.primary.withOpacity(0.2)),
                                  child: Text(
                                    controller.genres
                                        .firstWhere((item) =>
                                            item.id ==
                                            controller.movie!.genreIds[index])
                                        .name,
                                    style: Get.textTheme.caption,
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    width: 4,
                                  ),
                              itemCount: controller.movie!.genreIds.length),
                        ),
                        const SizedBox(
                          height: 44,
                        ),
                        Text(
                          'Description',
                          style: Get.textTheme.subtitle1,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          controller.movie!.overview,
                          style: Get.textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
