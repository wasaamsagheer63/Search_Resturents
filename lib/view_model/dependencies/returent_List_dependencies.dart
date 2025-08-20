
import 'package:get/get.dart';

import '../../Repository/algolia_repo.dart';
import '../resturent_list_view_model.dart';

class ReturentlistViewDependencies extends Bindings{
  @override
  void dependencies(){
    Get.put(AlgoliaRepository());
    Get.put(RestaurantListViewModel());
}
}