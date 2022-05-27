import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:q_movie_app/utils/app_colors.dart';
import 'package:q_movie_app/utils/assets.dart';
import 'package:q_movie_app/views/base_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
        const Duration(
          seconds: 3,
        ), () {
      Get.to(const BaseView());
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Container(
      color: AppColors.background,
      child: Center(
        child: Image.asset(
          Images.logo,
          width: 80,
          height: 80,
        ),
      ),
    );
  }
}
