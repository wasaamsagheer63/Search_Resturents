import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../view_model/map_view_model.dart';
import '../view_model/resturent_list_view_model.dart';



class MapBox extends GetView<MapViewModel> {
   final RestaurantListViewModel restaurantListViewModel=Get.find<RestaurantListViewModel>();
  @override




  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 110,
        backgroundColor: Color.fromRGBO(13, 161, 3, 0.9372549019607843),
        leadingWidth: MediaQuery.of(context).size.width,
        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Container(
              width: 300,
              decoration: BoxDecoration(),
              child: Text(
                "Nearby restaurants",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
         Obx((){
           return FlutterMap(
            mapController: controller.mapController,
            options: MapOptions(
              initialCenter: restaurantListViewModel.searchList.isNotEmpty ? LatLng(restaurantListViewModel.searchList.first.geoloc.lat.toDouble(),
                  restaurantListViewModel.searchList.first.geoloc.lng.toDouble()):LatLng(0, 0),
              initialZoom:4,
              maxZoom: 18,
              minZoom: 2,
            ),

            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
              MarkerLayer(
                  markers: restaurantListViewModel.searchList.map((map) {
                    return Marker(
                      width: 130,
                      height: 40,
                      point: LatLng(
                        map.geoloc.lat,
                        map.geoloc.lng,
                      ),
                      child: InkWell(
                        onTap: () {
                          controller.detail(map);
                          if (!controller.showcard.value) {
                            controller.showcard.value = true;
                          }

                        },
                        child: Chip(
                          avatar: Icon(
                            Icons.dinner_dining,
                            color: Colors.green,
                            size: 15,
                          ),
                          label: Text(map.Name, style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    );
                  }).toList(),
                )
            ],
           );}),
               Obx(() {
                return            controller.showcard.value == true?
                Positioned(
                  bottom: 20,
                  left: 10,
                  right: 10,
                  child: Card(
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(13),
                      ),

                      child: Container(
                        width: MediaQuery.of(context).size.width - 60,

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 140,
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(13),
                                ),
                                child: InkWell(
                                  onTap: () {

                                    controller.showcard.value = false;

                                  },
                                  child: Image.network(
                                    "https://tse1.mm.bing.net/th/id/OIP.aULahN1LnhlTmcuM_DptkAHaE9?pid=Api",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(top: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: Text(
                                      controller.Selectedrestaurant.value?.Name ?? " ",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 35,
                                    child: Chip(
                                      label: Text(
                                        controller.Selectedrestaurant.value?.Food_Type ?? "",
                                        style: TextStyle(
                                          color: Color.fromRGBO(9, 53, 1, 1.0),
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      labelStyle: TextStyle(fontSize: 12),
                                      backgroundColor: Color.fromRGBO(
                                        130,
                                        246,
                                        136,
                                        1.0,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        side: BorderSide(
                                          color: Color.fromRGBO(
                                            19,
                                            108,
                                            3,
                                            1.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  spacing: 2,
                                  children: [
                                    Text("⭐"),
                                    Text(
                                      controller.Selectedrestaurant.value?.Stars_count.toString() ?? "",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      "(${controller.Selectedrestaurant.value?.Reviews_Count ?? ""})",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Price :${controller.Selectedrestaurant.value?.Price_Range ?? ""}",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Positioned(
                  left: 150,
                  right: 150,
                  bottom: 40,
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(112, 115, 112, 0.6),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed("/restaurantList");
                      },
                      child: Icon(Icons.list, color: Colors.white),
                    ),
                  ),
                );}),
        ],
      ),
    );
  }
}
