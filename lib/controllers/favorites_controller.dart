import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:q_movie_app/data/models/movies_list.dart';

class FavoritesController extends GetxController {
  var favorites = RxList<Movie>();
  @override
  void onInit() {
    // GetStorage().erase();
    List? storedData = GetStorage().read<List>('fav');

    if (storedData != null) {
      favorites = storedData.map((e) => Movie.fromJson(e)).toList().obs;
    }
    ever(favorites, (_) {
      GetStorage().write('fav', favorites.toList());
    });
    super.onInit();
  }
}
