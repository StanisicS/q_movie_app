import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:q_movie_app/app_bindings.dart';
import 'package:q_movie_app/routes/app_pages.dart';
import 'package:q_movie_app/utils/app_colors.dart';
import 'package:q_movie_app/utils/app_text_theme.dart';
import 'package:q_movie_app/utils/connectivity_util.dart';

void main() async {
  await GetStorage.init();
  ConnectivityUtil.configureConnectivityStream();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.background,
      systemNavigationBarColor: AppColors.navBar,
      systemNavigationBarIconBrightness: Brightness.light));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Q Movies',
      theme: ThemeData(
          highlightColor: AppColors.primary.withOpacity(0.2),
          splashColor: AppColors.primary.withOpacity(0.2),
          textTheme: appTextTheme,
          fontFamily: 'SF Pro Display',
          dialogBackgroundColor: AppColors.background),
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      initialBinding: AppBindings(),
    );
  }
}
