import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:q_movie_app/utils/assets.dart';
import 'package:q_movie_app/utils/strings.dart';
import 'package:q_movie_app/utils/app_colors.dart';
import 'package:q_movie_app/views/favorites/favorites_screen.dart';
import 'package:q_movie_app/views/movies/movies_screen.dart';

class BaseView extends StatefulWidget {
  const BaseView({Key? key}) : super(key: key);

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int selIndex = 0;
  double animValue = 0.0;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.animation!.addListener(() {
      setState(() {
        animValue = tabController.animation!.value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            bottomNavigationBar: bottomBar(),
            body: TabBarView(
              controller: tabController,
              children: const [MoviesScreen(), FavoritesScreen()],
            ))
      ],
    );
  }

  Widget bottomBar() {
    return Material(
        color: AppColors.navBar,
        child: TabBar(
          labelColor: AppColors.primary,
          controller: tabController,
          unselectedLabelColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: AppColors.primary,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(color: AppColors.primary, width: 2.0),
            insets: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 60.0),
          ),
          tabs: [
            Tab(
              height: 60,
              iconMargin: EdgeInsets.zero,
              icon: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Svgs.mov,
                    color: animValue < 0.5 ? AppColors.primary : Colors.white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    AppStrings.mov,
                    style: Get.textTheme.caption!.copyWith(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.7,
                      color:
                          animValue < 0.5 ? AppColors.primary : AppColors.text,
                    ),
                  ),
                ],
              ),
              child: const SizedBox(height: 0),
            ),
            Tab(
              height: 60,
              iconMargin: EdgeInsets.zero,
              icon: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Svgs.bookAdd,
                    color: animValue > 0.5 ? AppColors.primary : Colors.white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    AppStrings.favorites,
                    style: Get.textTheme.caption!.copyWith(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.7,
                      color:
                          animValue > 0.5 ? AppColors.primary : AppColors.text,
                    ),
                  ),
                ],
              ),
              child: const SizedBox(height: 0),
            ),
          ],
        ));
  }
}
