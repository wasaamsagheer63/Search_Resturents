import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:service_provider_finder/ViewModel/ResturentListViewModel.dart';

import '../models/Resturents.dart';


class MapViewModel extends GetxController{
  ResturentListViewModel resturentListViewModel = Get.find();
  MapController mapController = MapController();
  RxBool showcard = false.obs;
   Rx<Resturents?> SelectedResturent  = Rx<Resturents?>(null);




  void onInit(){
    super.onInit();
    resturentListViewModel.SearchList.listen((_) {
      pointToTargets();
    });
  }
  void detail(Resturents resturentDetail){
    SelectedResturent.value= resturentDetail;
  }

  void pointToTargets(){
    if(resturentListViewModel.SearchList.isEmpty){
      return ;
    }
    List<LatLng> markPositions = resturentListViewModel.SearchList.map((map){
      return LatLng(map.geoloc.lat.toDouble(), map.geoloc.lng.toDouble());
    }).toList();

    if(markPositions.length ==1){
      mapController.move(markPositions.first,15.0);
    }
    else{
         double minlat=  markPositions.first.latitude;
         double maxlat = markPositions.first.latitude;
         double minlng = markPositions.first.longitude;
         double maxlng= markPositions.first.longitude;

         for( var position in markPositions){
           minlat = minlat < position.latitude ? minlat : position.latitude;
           maxlat = maxlat > position.latitude ? maxlat : position.latitude;
           minlng = minlng < position.longitude ? minlng : position.longitude;
           maxlng = maxlng > position.longitude ? maxlng : position.longitude;
         }

    LatLngBounds bounds =LatLngBounds(
      LatLng(minlat,minlng),
      LatLng(maxlat,maxlng)
    );
         mapController.fitCamera(CameraFit.bounds(bounds: bounds,

         padding: EdgeInsets.all(50.0),
         ));


    }
  }
}