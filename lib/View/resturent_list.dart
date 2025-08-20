import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_provider_finder/View/card_display.dart';
import '../view_model/resturent_list_view_model.dart';
import 'list_display.dart';



class RestaurantList extends GetView<RestaurantListViewModel> {
  TextEditingController searchController = TextEditingController();
  static const IconData border_all_rounded = IconData(
    0xf5d3,
    fontFamily: 'MaterialIcons',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx((){
        return SingleChildScrollView(
            controller: controller.scrollController,
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Color.fromRGBO(13, 161, 3, 0.9372549019607843),
              height: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hi Wasaam, 👋",
                              style: TextStyle(color: Colors.white, fontSize: 13),
                            ),
                            Text(
                              "Welcome back",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.4,
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        child: Icon(Icons.add_alert, color: Colors.white),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,

                          color: Color.fromRGBO(
                            11,
                            135,
                            3,
                            0.9372549019607843,
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
            Container(
              height: 150,
              child: Stack(
                children: [
                  Container(
                    color: Color.fromRGBO(13, 161, 3, 0.9372549019607843),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 25),
                    color: Color.fromRGBO(251, 251, 251, 0.96),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    height: 50,
                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        suffixIcon: Obx(() {
                          return !controller.filters()
                              ? SizedBox.shrink()
                              : Container(
                            margin: EdgeInsets.only(right: 5),

                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(
                                13,
                                161,
                                3,
                                0.9372549019607843,
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                Get.toNamed("/filters");},
                              onDoubleTap: () => controller.clearAll(),
                              child: Icon(
                                Icons.tune,
                                color: Colors.white,
                              ),
                            ),
                          );
                        }),
                        prefixIcon: Container(
                          margin: EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(
                              232,
                              236,
                              232,
                              0.9372549019607843,
                            ),
                          ),
                          child: Icon(Icons.search, size: 20),
                        ),
                        hintText: "Find restaurant....",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      onChanged: (value) {

                        controller.searchEditor(value);
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.fromLTRB(5, 55, 5, 0),
                    child:  controller.listFoodType.isEmpty
                          ? Center(child: CircularProgressIndicator())
                          : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: controller.listFoodType.map(
                                (item) => Container(
                              margin: EdgeInsets.only(left: 8),

                              child: InkWell(
                                onTap: () {

                                  controller.applyFoodFilter(
                                    item.facetvalue!,
                                  );

                                },
                                child:
                                controller.seletedFoodType.contains(
                                  item.facetvalue,
                                )
                                    ? Chip(
                                  label: Text(
                                    "${item.facetvalue} ${item.count}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromRGBO(
                                        2,
                                        97,
                                        2,
                                        0.9372549019607843,
                                      ),
                                    ),
                                  ),
                                  backgroundColor: Color.fromRGBO(
                                    109,
                                    251,
                                    109,
                                    0.9372549019607843,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(90),
                                    side: BorderSide(
                                      width: 1,
                                      color: Color.fromRGBO(
                                        2,
                                        133,
                                        2,
                                        0.9372549019607843,
                                      ),
                                    ),
                                  ),
                                )
                                    : Chip(
                                  label: Text(
                                    "${item.facetvalue} ${item.count}",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  backgroundColor: Color.fromRGBO(
                                    234,
                                    236,
                                    234,
                                    0.9372549019607843,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(90),
                                  ),
                                ),
                              ),
                            ),
                          ).toList(),
                        ),
                    )
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(13, 98, 5, 0),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                          child: Row(
                            spacing: 10,
                            children: [
                              InkWell(
                                onTap: () {

                                  Get.toNamed("/Map");

                                },
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Color.fromRGBO(
                                        13,
                                        161,
                                        3,
                                        0.9372549019607843,
                                      ),
                                    ),

                                    Container(
                                      margin: EdgeInsets.fromLTRB(5, 4, 0, 0),
                                      child: Icon(
                                        Icons.location_on,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "Nearby restaurants",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 130),
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundColor: Color.fromRGBO(
                                  232,
                                  236,
                                  232,
                                  0.9372549019607843,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {

                                  if (controller.cardPage.value) {
                                    controller.cardPage.value = false;
                                  } else {
                                    controller.cardPage.value = true;
                                  }

                                },
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromRGBO(
                                      232,
                                      236,
                                      232,
                                      0.9372549019607843,
                                    ),
                                  ),
                                  child: controller.cardPage.value == true
                                      ? Container(
                                    margin: EdgeInsets.fromLTRB(6, 6, 0, 0,),
                                    child: Icon(
                                      Icons.list,
                                      color: Colors.grey,
                                      size: 17,
                                    ),
                                  )
                                      : Container(
                                    margin: EdgeInsets.fromLTRB(
                                      6,
                                      6,
                                      0,
                                      0,
                                    ),

                                    child: Icon(
                                      Icons.border_all_rounded,
                                      color: Colors.grey,
                                      size: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),controller.notFound()?Container(
              margin: EdgeInsets.only(top:30),
              child: Center(
                child: Text("Not Found Any Result ....",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              ),
            ):
            controller.searchList.isEmpty && !controller.filters()?
            Center(
              child: CircularProgressIndicator(),
            ):
            ListView.builder(
              shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.searchList.length,
                itemBuilder: ((context,index){
              final item = controller.searchList[index];
              return controller.cardPage.value == true
                  ? CardDisplay(item,index)
                  :ListDisplay(item,index);})),
          controller.loadingData.value?Container(
            margin: EdgeInsets.symmetric(vertical:50),
              child: CircularProgressIndicator(color: Colors.green,strokeWidth: 5,)):SizedBox.shrink()
          ]));

    }),
    );
  }
}
