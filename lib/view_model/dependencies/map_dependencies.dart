
import 'package:get/get.dart';
import '../../Repository/algolia_repo.dart';
import '../map_view_model.dart';
import '../resturent_list_view_model.dart';

class MapDependencies extends Bindings{
  @override
  void dependencies(){
    Get.put(AlgoliaRepository());
    Get.put(RestaurantListViewModel());
    Get.put(MapViewModel());
}
}