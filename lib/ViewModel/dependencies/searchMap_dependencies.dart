
import 'package:get/get.dart';
import 'package:service_provider_finder/ViewModel/MapSearchViewModel.dart';

import '../../Repository/algolia_repo.dart';

class SearchViewDependencies extends Bindings{
  @override
  void dependencies(){
    Get.put(AlgoliaRepository());
    Get.put(MapSearchViewModel());
}
}