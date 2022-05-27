import 'package:get/get.dart';
import 'package:q_movie_app/controllers/base_controller.dart';
import 'package:q_movie_app/data/api_repository.dart';
import 'package:q_movie_app/data/api_repositoy_impl.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut<ApiRepository>(() => ApiRepositoryImpl());
    Get.put<BaseController>(BaseController(), permanent: true);
  }
}
