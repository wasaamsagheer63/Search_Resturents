
import 'package:get/get.dart';
import 'package:service_provider_finder/ViewModel/MapSearchViewModel.dart';
import 'package:service_provider_finder/ViewModel/googleViewModel.dart';

import '../../Repository/algolia_repo.dart';

class MapDependencies extends Bindings{
  @override
  void dependencies(){
    Get.put(AlgoliaRepository());
    Get.put(MapSearchViewModel());
    Get.put(MapControllerforMap());
}
}