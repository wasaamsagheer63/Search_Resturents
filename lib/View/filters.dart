import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_provider_finder/ViewModel/ResturentListViewModel.dart';

class ApplyFilteres extends GetView<ResturentListViewModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Filters",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.toNamed("/ResturentList");
            },
            icon: Icon(Icons.chevron_left),
          ),),

        body: Obx(() => Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
              children: [
                SizedBox(height: 8),
                Expanded(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 200,
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                            "Select Price Range",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: controller.SeletedPriceType.isNotEmpty
                                                  ? Color.fromRGBO(
                                                13,
                                                161,
                                                3,
                                                0.9372549019607843,
                                              )
                                                  : Colors.grey,
                                            ),
                                          ),
                                    Column(children:controller.ListPrice_Range.value.map((item) {
                                      return Padding(
                                          padding: EdgeInsets.all(5),
                                          child:checkBoxtitleComponent(item, controller.SeletedPriceType.contains(item), ()=> controller.applyPricefilter(item)

                                          ));}).toList())
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 30),
                            Container(
                              width: 200,
                              height: MediaQuery.of(context).size.height * 0.7,
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
                                            color: controller.SeletedAreaType.isNotEmpty
                                                ? Color.fromRGBO(
                                              13,
                                              161,
                                              3,
                                              0.9372549019607843,
                                            )
                                                : Colors.grey,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () => controller.showArea(),
                                          child: Text(controller.showMoreAreas.value? "Show less":"Show more",
                                            style: TextStyle(fontSize: 13,color:Colors.green),
                                          ),
                                        ),
                                      ],
                                    ),
                                  Column(children:controller.showMoreAreas.value ? controller.ListArea.value.map((item) {
                                      return Padding(
                                          padding: EdgeInsets.all(5),
                                          child:checkBoxtitleComponent(item, controller.SeletedAreaType.contains(item),()=>controller.applyAreafilter(item)));}).toList():
                                    controller.ListArea.take(4).map((item) {
                                      return Padding(
                                          padding: EdgeInsets.all(5),
                                          child:checkBoxtitleComponent(item, controller.SeletedAreaType.contains(item),()=>controller.applyAreafilter(item)));}).toList())
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 30),
                            Container(
                              width: 200,
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Select Dining Style",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: controller.SeletedDiningType.isNotEmpty
                                            ? Color.fromRGBO(
                                          13,
                                          161,
                                          3,
                                          0.9372549019607843,
                                        )
                                            : Colors.grey,
                                      ),
                                    ),
                                    Column(children:controller.ListDining_Style.value.map((item) {
                                      return Padding(
                                          padding: EdgeInsets.all(5),
                                          child:checkBoxtitleComponent(item, controller.SeletedDiningType.contains(item),()=>controller.applyDinningfilter(item)));}).toList())
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 30),
                            Container(
                              width: 200,
                              height: MediaQuery.of(context).size.height * 0.7,
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
                                        color: controller.SeletedRatingType.isNotEmpty
                                            ? Color.fromRGBO(
                                          13,
                                          161,
                                          3,
                                          0.9372549019607843,
                                        )
                                            : Colors.grey,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () => controller.showRating(),
                                      child: Text(controller.showMoreRating.value? "Show less":"Show more",
                                        style: TextStyle(fontSize: 13,color:Colors.green),
                                      ),
                                    ),
                                  ],
                                    ),
                                    Column(children:controller.showMoreRating.value ? controller.ListRating.value.map((item) {
                                      return Padding(
                                          padding: EdgeInsets.all(5),
                                          child:checkBoxtitleComponent(item, controller.SeletedRatingType.contains(item),()=>controller.applyRatingfilter(item),isRating: true));}).toList():
                                    controller.ListRating.take(4).map((item) {
                                      return Padding(
                                          padding: EdgeInsets.all(5),
                                          child:checkBoxtitleComponent(item, controller.SeletedRatingType.contains(item),()=>controller.applyRatingfilter(item),isRating: true));}).toList())

                                  ],
                                ),
                              ),)
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
                        controller.clearall();
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
                              " Find Resturent",
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
        )));

  }
  @override

  Widget checkBoxtitleComponent(
      String item,
      bool isSelected,
      VoidCallback onChanged,
  {bool isRating = false}
      ){
    return Container(

      margin: EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isSelected ? Colors.green : Colors.grey,
        ),
      ),
      child: CheckboxListTile(
        fillColor:WidgetStateProperty.all(Colors.white),
        checkColor: Colors.green,
        contentPadding: EdgeInsets.symmetric(horizontal: 8),
        title: isRating? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children:[ Icon(isSelected ?Icons.star:Icons.star_border_outlined,color: isSelected?Colors.yellow:Colors.grey,),
          Text(item, style: TextStyle(fontSize: 12,color: isSelected ? Colors.green : Colors.grey),),
        ])
            :Text(item, style: TextStyle(fontSize: 12,color: isSelected ? Colors.green : Colors.grey),),
        value: isSelected,
        onChanged: (value) => onChanged()
      ),
    );
  }


}