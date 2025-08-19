
import 'package:get/get.dart';
import 'package:service_provider_finder/ViewModel/ResturentListViewModel.dart';

import '../../Repository/algolia_repo.dart';

class ReturentlistViewDependencies extends Bindings{
  @override
  void dependencies(){
    Get.put(AlgoliaRepository());
    Get.put(ResturentListViewModel());
}
}