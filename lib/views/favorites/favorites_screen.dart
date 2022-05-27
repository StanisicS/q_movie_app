import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:q_movie_app/controllers/base_controller.dart';
import 'package:q_movie_app/controllers/favorites_controller.dart';
import 'package:q_movie_app/routes/app_pages.dart';
import 'package:q_movie_app/utils/assets.dart';
import 'package:q_movie_app/utils/spacing.dart';
import 'package:q_movie_app/utils/strings.dart';
import 'package:q_movie_app/utils/app_colors.dart';
import 'package:q_movie_app/views/widgets/header.dart';
import 'package:q_movie_app/views/widgets/movie_list_tile.dart';

class FavoritesScreen extends GetView<FavoritesController> {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BaseController c = Get.find();

    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.background,
          body: Obx(
            () => Stack(children: [
              if (controller.favorites.isEmpty)
                Padding(
                  padding: wrapper,
                  child: Column(
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
                      Row(
                        children: [
                          Text(
                            AppStrings.favorites,
                            style: Get.textTheme.headline1,
                          ),
                        ],
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                      SvgPicture.asset(
                        Svgs.fav2x,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Nothing yet here :)',
                        style: Get.textTheme.bodyText1!
                            .copyWith(fontStyle: FontStyle.italic),
                      ),
                      const Spacer(
                        flex: 3,
                      ),
                    ],
                  ),
                ),
              Obx(() => ListView.separated(
                    padding: wrapper,
                    shrinkWrap: true,
                    // reverse: true,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 20,
                    ),
                    itemCount: controller.favorites.length,
                    itemBuilder: (context, index) {
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
                              height: 20,
                            ),
                            Text(
                              AppStrings.favorites,
                              style: Get.textTheme.headline1,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            MovieListTile(
                              backdropPath:
                                  controller.favorites[index].backdropPath,
                              title: controller.favorites[index].title,
                              voteAverage:
                                  controller.favorites[index].voteAverage,
                              movieItem: controller.favorites[index],
                              icon: InkWell(
                                onTap: () {
                                  var res = c.movies.firstWhere((element) =>
                                      element == controller.favorites[index]);

                                  res.isFav = false;
                                  controller.favorites.removeAt(index);
                                  controller.favorites.refresh();
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(6.0),
                                  child: SvgPicture.asset(
                                    Svgs.bookFilled,
                                  ),
                                ),
                                highlightColor:
                                    AppColors.primary.withOpacity(0.2),
                                splashColor: AppColors.primary.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              onTap: () async {
                                var res = c.movies.firstWhere((element) =>
                                    element == controller.favorites[index]);
                                // c.favorites.indexWhere((element) => false)
                                c.getMovie(res.id!).then((value) {
                                  c.movie = res;
                                  Get.toNamed(AppRoutes.details);
                                });
                              },
                            ),
                          ],
                        );
                      }
                      return MovieListTile(
                        backdropPath: controller.favorites[index].backdropPath,
                        title: controller.favorites[index].title,
                        voteAverage: controller.favorites[index].voteAverage,
                        movieItem: controller.favorites[index],
                        icon: InkWell(
                          onTap: () {
                            var res = c.movies.firstWhere((element) =>
                                element == controller.favorites[index]);
                            // index = index - 1;
                            res.isFav = false;
                            controller.favorites.removeAt(index);
                            controller.favorites.refresh();
                          },
                          child: Container(
                            margin: const EdgeInsets.all(6.0),
                            child: SvgPicture.asset(
                              Svgs.bookFilled,
                            ),
                          ),
                          highlightColor: AppColors.primary.withOpacity(0.2),
                          splashColor: AppColors.primary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        onTap: () async {
                          var res = c.movies.firstWhere((element) =>
                              element == controller.favorites[index]);
                          // c.favorites.indexWhere((element) => false)
                          c.getMovie(res.id!).then((value) {
                            c.movie = res;
                            Get.toNamed(AppRoutes.details);
                          });
                        },
                      );
                    },
                  ))
            ]),
          )),
    );
    // bottomNavigationBar: const BottomNavBar(),
  }
}
