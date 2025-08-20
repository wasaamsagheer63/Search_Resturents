import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view_model/resturent_list_view_model.dart';

class ApplyFilteres extends GetView<RestaurantListViewModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Filters",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.chevron_left),
          ),),

        body: Obx(() =>
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                  children: [
                  SizedBox(height: 8),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                  Container(
                  padding: EdgeInsets.all(8),
                  width: 300,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.black)
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select Price Range",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: controller.seletedPriceType.isNotEmpty
                                ? Color.fromRGBO(
                              13,
                              161,
                              3,
                              0.9372549019607843,
                            )
                                : Colors.black,
                          ),
                        ),
                        Column(children: controller.listPriceRange.map((
                            item) {
                          return checkBoxtitleComponent(item,
                              controller.seletedPriceType.contains(
                                  item), () =>
                                  controller.applyPriceFilter(item)

                          );
                        }).toList())
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.black)
                  ),
                  width: 300,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Select Area",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: controller.seletedAreaType.isNotEmpty
                                    ? Color.fromRGBO(
                                  13,
                                  161,
                                  3,
                                  0.9372549019607843,
                                )
                                    : Colors.black,
                              ),
                            ),
                            InkWell(
                              onTap: () => controller.showArea(),
                              child: Text(controller.showMoreAreas.value
                                  ? "Show less"
                                  : "Show more",
                                style: TextStyle(
                                    fontSize: 14,fontWeight: FontWeight.bold, color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                        Column(children: controller.showMoreAreas.value
                            ? controller.listArea.map((item) {
                          return checkBoxtitleComponent(item,
                              controller.seletedAreaType.contains(
                                  item), () =>
                                  controller.applyAreaFilter(item));
                        }).toList()
                            :
                        controller.listArea.take(4).map((item) {
                          return checkBoxtitleComponent(item,
                              controller.seletedAreaType.contains(
                                  item), () =>
                                  controller.applyAreaFilter(item));
                        }).toList())
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.black),
                  ),
                  width: 300,

                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select Dining Style",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: controller.seletedDiningType.isNotEmpty
                                ? Color.fromRGBO(
                              13,
                              161,
                              3,
                              0.9372549019607843,
                            )
                                : Colors.black,
                          ),
                        ),
                        Column(children: controller.listDiningStyle.map((
                            item) {
                          return checkBoxtitleComponent(item,
                              controller.seletedDiningType.contains(
                                  item), () =>
                                  controller.applyDinningFilter(item));
                        }).toList())
                      ],
                    ),
                  ),
                ),

                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.black)
                          ),
                          width: 300,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Select Rating",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: controller.seletedRatingType.isNotEmpty
                                            ? Color.fromRGBO(
                                          13,
                                          161,
                                          3,
                                          0.9372549019607843,
                                        )
                                            : Colors.black,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () => controller.showRating(),
                                      child: Text(controller.showMoreRating.value
                                          ? "Show less"
                                          : "Show more",
                                        style: TextStyle(
                                            fontSize: 14,fontWeight: FontWeight.bold, color: Colors.green),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(children: controller.showMoreRating.value
                                    ? controller.listRating.map((item) {
                                  return checkBoxtitleComponent(item,
                                      controller.seletedRatingType.contains(item), () =>
                                          controller.applyRatingFilter(item),
                                   isRating: true);
                                }).toList()
                                    :
                                controller.listRating.take(4).map((item) {
                                  return checkBoxtitleComponent(item,
                                      controller.seletedRatingType.contains(item), () =>
                                          controller.applyRatingFilter(item),
                                  isRating: true);
                                }).toList())
                              ],
                            ),
                          ),
                        )

            ])),
    ),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
    InkWell(
    child: Stack(
    children: [
    Text(
    "Clear all",
    style: TextStyle(
    fontWeight: FontWeight.w700,
    color: Color.fromRGBO(
    96,
    94,
    94,
    0.9372549019607843,
    ),
    ),
    ),
    Container(
    margin: EdgeInsets.fromLTRB(0, 18, 0, 0),
    width: 58,
    height: 2,
    decoration: BoxDecoration(
    color: Color.fromRGBO(
    96,
    94,
    94,
    0.9372549019607843,
    ),
    ),
    ),
    ],
    ),
    onTap: (){
    controller.clearAll();
    },
    ),
    Stack(
    children: [
    ElevatedButton(
    onPressed: () {
    Get.back();
    },
    child: Container(
    margin: EdgeInsets.only(left: 5),
    child: Text(
    " Find restaurant",
    style: TextStyle(
    color: Colors.white,
    fontSize: 12,
    ),
    ),
    ),
    style: ElevatedButton.styleFrom(
    backgroundColor: Color.fromRGBO(
    13,
    161,
    3,
    0.9372549019607843,
    ),
    ),
    ),
    Container(
    margin: EdgeInsets.fromLTRB(11, 15, 0, 0),
    child: Icon(
    Icons.location_on,
    color: Colors.white,
    size: 16,
    ),
    ),
    ],
    ),
    ],
    ),


    ]),
    )
    )
    );

  }

  @override
  Widget checkBoxtitleComponent(String item,
      bool isSelected,
      VoidCallback onChanged,
      {bool isRating = false}) {
    return Container(

      child: CheckboxListTile(
          fillColor: WidgetStateProperty.all(Colors.white),
          checkColor: Colors.green,
          contentPadding: EdgeInsets.symmetric(horizontal: 8),
          title: isRating ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 6,
              children: [
                Icon(isSelected ? Icons.star : Icons.star_border_outlined,
                  color: isSelected ? Colors.yellow : Colors.black,),
                Text(item, style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,
                    color: isSelected ? Colors.green : Colors.black),),
              ])
              : Text(item, style: TextStyle(
              fontSize: 14,fontWeight: FontWeight.w900, color: isSelected ? Colors.green : Colors.black),),
          value: isSelected,
          onChanged: (value) => onChanged()
      ),
    );
  }


}