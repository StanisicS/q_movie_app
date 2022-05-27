import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:q_movie_app/controllers/base_controller.dart';
import 'package:q_movie_app/controllers/favorites_controller.dart';
import 'package:q_movie_app/routes/app_pages.dart';
import 'package:q_movie_app/utils/assets.dart';
import 'package:q_movie_app/utils/spacing.dart';
import 'package:q_movie_app/utils/app_colors.dart';
import 'package:q_movie_app/utils/strings.dart';
import 'package:q_movie_app/views/widgets/header.dart';
import 'package:q_movie_app/views/widgets/movie_list_tile.dart';

class MoviesScreen extends GetView<BaseController> {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FavoritesController favController = Get.put(FavoritesController());

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Obx(
          () => ListView.separated(
            padding: wrapper,
            shrinkWrap: true,
            controller: controller.scroll,
            separatorBuilder: (context, index) => const SizedBox(
              height: 20,
            ),
            itemCount: controller.movies.length,
            itemBuilder: (context, index) {
              if (controller.isToLoadMore &&
                  controller.movies.length - 1 == index) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (index == 0) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Header(
                      icon: Image.asset(
                        Images.logo,
                        width: 28,
                        height: 28,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      AppStrings.popular,
                      style: Get.textTheme.headline1,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MovieListTile(
                      backdropPath: controller.movies[index].backdropPath,
                      title: controller.movies[index].title,
                      voteAverage: controller.movies[index].voteAverage,
                      movieItem: controller.movies[index],
                      icon: Obx(
                        () => InkWell(
                          onTap: () {
                            controller.movies[index].isFav =
                                !controller.movies[index].isFav;

                            if (controller.movies[index].isFav) {
                              favController.favorites
                                  .add(controller.movies[index]);
                              controller.movies[index].isFav = true;
                            } else {
                              favController.favorites.removeAt(index);
                              controller.movies[index].isFav = false;
                            }
                            controller.movies.refresh();
                          },
                          child: Container(
                            margin: const EdgeInsets.all(6.0),
                            child: SvgPicture.asset(
                              !controller.movies[index].isFav
                                  ? Svgs.book
                                  : Svgs.bookFilled,
                            ),
                          ),
                          highlightColor: AppColors.primary.withOpacity(0.2),
                          splashColor: AppColors.primary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onTap: () async {
                        controller
                            .getMovie(controller.movies[index].id!)
                            .then((value) {
                          controller.movie = controller.movies[index];
                          Get.toNamed(AppRoutes.details);
                        });
                      },
                    ),
                  ],
                );
              }
              return MovieListTile(
                backdropPath: controller.movies[index].backdropPath,
                title: controller.movies[index].title,
                voteAverage: controller.movies[index].voteAverage,
                movieItem: controller.movies[index],
                icon: Obx(
                  () => InkWell(
                    onTap: () {
                      controller.movies[index].isFav =
                          !controller.movies[index].isFav;

                      if (controller.movies[index].isFav) {
                        favController.favorites.add(controller.movies[index]);
                        controller.movies[index].isFav = true;
                      } else {
                        favController.favorites.removeAt(index);
                        controller.movies[index].isFav = false;
                      }
                      controller.movies.refresh();
                    },
                    child: Container(
                      margin: const EdgeInsets.all(6.0),
                      child: SvgPicture.asset(
                        !controller.movies[index].isFav
                            ? Svgs.book
                            : Svgs.bookFilled,
                      ),
                    ),
                    highlightColor: AppColors.primary.withOpacity(0.2),
                    splashColor: AppColors.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                onTap: () async {
                  controller
                      .getMovie(controller.movies[index].id!)
                      .then((value) {
                    controller.movie = controller.movies[index];
                    Get.toNamed(AppRoutes.details);
                  });
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
