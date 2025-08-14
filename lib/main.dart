import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:service_provider_finder/View/filters.dart';
import 'package:service_provider_finder/View/googleMap.dart';
import 'package:service_provider_finder/ViewModel/dependencies/mapdependencies.dart';

import 'View/resturentlist.dart';
import 'ViewModel/dependencies/searchMap_dependencies.dart';

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
        GetPage(name: "/ResturentList", page: () =>ResturentList(),binding:SearchViewDependencies()),
        GetPage(name: "/filters", page: () =>ApplyFilteres(),binding:SearchViewDependencies()),
      ],
      initialRoute: "/ResturentList",
    );
  }
}
