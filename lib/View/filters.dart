import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_provider_finder/View/resturentlist.dart';
import 'package:service_provider_finder/ViewModel/MapSearchViewModel.dart';

class ApplyFilteres extends StatefulWidget {
  const ApplyFilteres({super.key});

  @override
  State<ApplyFilteres> createState() => _ApplyFilteresState();
}

class _ApplyFilteresState extends State<ApplyFilteres> {
  late final MapSearchViewModel mapSearchViewModel;
bool tuner =true;
  @override
  void initState(){
    super.initState();
    mapSearchViewModel = Get.find();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 70,
                children: [
                  IconButton(onPressed: (){
                    setState(() {
                      Get.toNamed("/ResturentList");
                    });
                  }, icon: Icon(Icons.chevron_left)),
                  Text("Filters",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold))
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Price Range",style: TextStyle(fontWeight: FontWeight.w700)),
                      TextButton(onPressed: (){
                        setState(() {
                          mapSearchViewModel.clearPrice();
                        });
                      }, child: Text("Reset",style: TextStyle(color:Colors.grey,fontWeight: FontWeight.w600,fontSize: 12),))
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 1),
                    child: Obx(() {
                      return mapSearchViewModel.ListPrice_Range.isEmpty
                          ? Center(child: CircularProgressIndicator())
                          : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: mapSearchViewModel.ListPrice_Range.map(
                                (item) => Container(
                              margin: EdgeInsets.only(left: 8),

                              child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      mapSearchViewModel.applyPricefilter(item);
                                    });      },
                                  child:mapSearchViewModel.SeletedPriceType.contains(item)?Chip(
                                    label: Text(
                                      item,
                                      style: TextStyle(fontSize: 12,color:Color.fromRGBO(
                                        2,
                                        97,
                                        2,
                                        0.9372549019607843,
                                      ) ),
                                    ),
                                    backgroundColor:Color.fromRGBO(
                                      109,
                                      251,
                                      109,
                                      0.9372549019607843,
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(90),
                                        side: BorderSide(width: 1,color:Color.fromRGBO(
                                          2,
                                          133,
                                          2,
                                          0.9372549019607843,
                                        ))
                                    ),
                                  ):Chip(
                                    label: Text(
                                      item,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    backgroundColor:Color.fromRGBO(
                                      234,
                                      236,
                                      234,
                                      0.9372549019607843,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(90),
                                    ),
                                  )

                              ),
                            ),
                          ).toList(),
                        ),
                      );
                    }),
                  )
                ],
              ),

              Container(
                margin: EdgeInsets.only(top:5),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Area",style: TextStyle(fontWeight: FontWeight.w700)),
                    TextButton(onPressed: (){
                      setState(() {
                        mapSearchViewModel.clearArea();

                      });                    }, child: Text("Reset",style: TextStyle(color:Colors.grey,fontWeight: FontWeight.w600,fontSize: 12),))
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 1),
                child: Obx(() {
                  return mapSearchViewModel.ListArea.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: mapSearchViewModel.ListArea.map(
                            (item) => Container(
                          margin: EdgeInsets.only(left: 8),

                          child: InkWell(
                              onTap: (){
                                setState(() {
                                  mapSearchViewModel.applyAreafilter(item);
                                });      },
                              child:mapSearchViewModel.SeletedAreaType.contains(item)?Chip(
                                label: Text(
                                  item,
                                  style: TextStyle(fontSize: 12,color:Color.fromRGBO(
                                    2,
                                    97,
                                    2,
                                    0.9372549019607843,
                                  ) ),
                                ),
                                backgroundColor:Color.fromRGBO(
                                  109,
                                  251,
                                  109,
                                  0.9372549019607843,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(90),
                                    side: BorderSide(width: 1,color:Color.fromRGBO(
                                      2,
                                      133,
                                      2,
                                      0.9372549019607843,
                                    ))
                                ),
                              ):Chip(
                                label: Text(
                                  item,
                                  style: TextStyle(fontSize: 12),
                                ),
                                backgroundColor:Color.fromRGBO(
                                  234,
                                  236,
                                  234,
                                  0.9372549019607843,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(90),
                                ),
                              )

                          ),
                        ),
                      ).toList(),
                    ),
                  );
                }),
              ),
              Container(
                margin: EdgeInsets.only(top:5),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Dinning Style",style: TextStyle(fontWeight: FontWeight.w700)),
                    TextButton(onPressed: (){
                      setState(() {
                        mapSearchViewModel.clearDining();
                      });
                    }, child: Text("Reset",style: TextStyle(color:Colors.grey,fontWeight: FontWeight.w600,fontSize: 12),))
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top:5),
                child: Obx(() {
                  return mapSearchViewModel.ListDining_Style.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: mapSearchViewModel.ListDining_Style.map(
                            (item) => Container(
                          margin: EdgeInsets.only(left: 8),

                          child: InkWell(
                              onTap: (){
                                setState(() {
                                  mapSearchViewModel.applyDinningfilter(item);
                                });
                              },
                              child:mapSearchViewModel.SeletedDiningType.contains(item)?Chip(
                                label: Text(
                                  item,
                                  style: TextStyle(fontSize: 12,color:Color.fromRGBO(
                                    2,
                                    97,
                                    2,
                                    0.9372549019607843,
                                  ) ),
                                ),
                                backgroundColor:Color.fromRGBO(
                                  109,
                                  251,
                                  109,
                                  0.9372549019607843,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(90),
                                    side: BorderSide(width: 1,color:Color.fromRGBO(
                                      2,
                                      133,
                                      2,
                                      0.9372549019607843,
                                    ))
                                ),
                              ):Chip(
                                label: Text(
                                  item,
                                  style: TextStyle(fontSize: 12),
                                ),
                                backgroundColor:Color.fromRGBO(
                                  234,
                                  236,
                                  234,
                                  0.9372549019607843,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(90),
                                ),
                              )

                          ),
                        ),
                      ).toList(),
                    ),
                  );
                }),
              ),
        SizedBox(height: 100,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        mapSearchViewModel.clearall();
                      });
                    },
                    child: Stack(
                      children: [
                        Text("Clear all",style: TextStyle(fontWeight: FontWeight.w700,color: Color.fromRGBO(
                            96, 94, 94, 0.9372549019607843)),),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 18, 0, 0),
                          width: 58,
                          height: 2,
                          decoration: BoxDecoration(
                              color:Color.fromRGBO(
                                  96, 94, 94, 0.9372549019607843)
                          ),
                        )
                      ],
                    ),
                  ),
                  Stack(children: [
                    ElevatedButton(onPressed: (){
                      Get.toNamed("/ResturentList");
                    }, child: Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Text(" Find Resturent",style: TextStyle(color:Colors.white,fontSize: 12),)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(13, 161, 3, 0.9372549019607843),
                      ),),
                    Container(
                        margin: EdgeInsets.fromLTRB(11, 15, 0, 0),
                        child: Icon(Icons.location_on,color:Colors.white,size: 16,)),

                  ]
                    ,)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
