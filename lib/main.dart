import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:service_provider_finder/View/filters.dart';
import 'package:service_provider_finder/View/map_box.dart';
import 'package:service_provider_finder/view_model/dependencies/map_dependencies.dart';
import 'package:service_provider_finder/view_model/dependencies/returent_List_dependencies.dart';

import 'View/resturent_list.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: "/Map", page: () =>MapBox(),binding:MapDependencies()),
        GetPage(name: "/restaurantList", page: () =>RestaurantList(),binding:ReturentlistViewDependencies()),
        GetPage(name: "/filters", page: () =>ApplyFilteres(),binding:ReturentlistViewDependencies()),
      ],
      initialRoute: "/restaurantList",
    );
  }
}
