import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../ViewModel/MapSearchViewModel.dart';
import '../models/Resturents.dart';

class ResturentList extends StatefulWidget {

  @override
  State<ResturentList> createState() => _ResturentListState();
}

class _ResturentListState extends State<ResturentList> {
  late final MapSearchViewModel mapSearchViewModel;
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool cardPage = true;
  bool mapPage = false;
  static const IconData border_all_rounded = IconData(
    0xf5d3,
    fontFamily: 'MaterialIcons',
  );

  void initState() {
    super.initState();
    mapSearchViewModel = Get.find();

    scrollController.addListener((){
      if (!scrollController.hasClients) return;

      if(scrollController.position.pixels >= scrollController.position.maxScrollExtent-200){
        mapSearchViewModel.loadMoreData();
      }
    });
  }
  @override
  void dispose() {
    scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        controller: scrollController,
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
                  SizedBox(height: 30,),
                  Container(
                    margin: EdgeInsets.only(left: 30),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Hi Wasaam,",
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                        Text("👋", style: TextStyle(fontSize: 20)),
                        SizedBox(width: MediaQuery.of(context).size.width-190,),
                        Container(
                          width: 40,
                          height: 40,
                          child: Icon(Icons.add_alert,color: Colors.white,),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,

                            color: Color.fromRGBO(
                                11, 135, 3, 0.9372549019607843),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left:20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Welcome back",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 150,
              child: Stack(
                  children: [
                    Container(color: Color.fromRGBO(13, 161, 3, 0.9372549019607843)),
                    Container(
                      margin: EdgeInsets.only(top: 25),
                      color: Color.fromRGBO(251, 251, 251, 0.96),
                    ),
                    Container(
                      width: 260,
                      height: 50,
                      margin: EdgeInsets.only(left: 46),
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          suffixIcon: Obx((){
                            return !mapSearchViewModel.filters() ? SizedBox.shrink():Container(
                              child: InkWell(
                                onTap: ()=>Get.toNamed("/filters"),
                                child: Icon(Icons.tune,color:Colors.white),
                              ),
                              margin: EdgeInsets.only(right:5),

                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(
                                  13,
                                  161,
                                  3,
                                  0.9372549019607843,
                                ),
                              ),
                            );}),
                            prefixIcon:Container(
                            margin: EdgeInsets.only(
                          left:5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(
                                232,
                                236,
                                232,
                                0.9372549019607843,
                              ),
                            ),
                            child:Icon(Icons.search,size:20),
                          ),
                          hintText: "Find Resturent",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onChanged: (value){
                          setState(() {
                            mapSearchViewModel.searchEditor(value);
                          });
                        },
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.fromLTRB(5, 55, 5, 0),
                      child: Obx(() {
                        return mapSearchViewModel.ListFood_Type.isEmpty
                            ? Center(child: CircularProgressIndicator())
                            : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: mapSearchViewModel.ListFood_Type.map(
                                  (item) => Container(
                                margin: EdgeInsets.only(left: 8),

                                child: InkWell(
                                    onTap: (){

                                      setState(() {
                                        mapSearchViewModel.applyfoodfilter(item.facetvalue!);
                                      });
                                    },
                                    child:mapSearchViewModel.SeletedFoodType.contains(item.facetvalue)?Chip(
                                      label: Text("${item.facetvalue} ${item.count}"
                                        ,
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
                                        "${item.facetvalue} ${item.count}",
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
                      margin: EdgeInsets.fromLTRB(13, 98, 5, 0),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            child: Row(
                              spacing: 10,
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      Get.toNamed("/Map");
                                    });
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
                                        margin:EdgeInsets.fromLTRB(5, 4, 0, 0),
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
                                  "Nearby Resturents",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 130),
                          Container(
                            margin: EdgeInsets.only(top:4),
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Color.fromRGBO(232, 236, 232, 0.9372549019607843,),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (cardPage) {
                                        cardPage = false;
                                      } else {
                                        cardPage = true;
                                      }
                                    });
                                  },
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(

                                        shape: BoxShape.circle,
                                        color:Color.fromRGBO(232, 236, 232, 0.9372549019607843,)
                                    ),
                                    child:cardPage == true
                                        ? Container(
                                        margin: EdgeInsets.fromLTRB(6, 6, 0, 0),
                                        child: Icon(Icons.list, color: Colors.grey,size: 17,))
                                        : Container(
                                      margin: EdgeInsets.fromLTRB(6, 6, 0, 0),

                                      child: Icon(Icons.border_all_rounded,
                                        color: Colors.grey,size: 17,
                                      ),
                                        )
                                    ),
                                ),
                              ]  ),

                            ),
                        ]
                      ),
                    ),
                  ] ),
            ),
              cardPage == true ?Obx(() {
              return mapSearchViewModel.SearchList.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: mapSearchViewModel.SearchList.length +(mapSearchViewModel.moreData.value && mapSearchViewModel.loadingData.value ? 1: 0),
                itemBuilder: (context, index) {
                  if(index == mapSearchViewModel.SearchList.length){
                    return Obx(() =>mapSearchViewModel.loadingData.value ? Center(child: CircularProgressIndicator(),):SizedBox.shrink()
                    );
                  }
                  Resturents resturent = mapSearchViewModel.SearchList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      onTap: (){},
                      child: Card(
                        child: Container(
                          height: 170,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 100,
                                child: Stack(
                                  children:[
                                    Container(
                                    height: 85,
                                    width: double.infinity,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                                        child: Image.network("https://tse1.mm.bing.net/th/id/OIP.aULahN1LnhlTmcuM_DptkAHaE9?pid=Api",fit: BoxFit.cover,)),
                                  ),
                                Positioned(
                                  top:42,
                                  left:20,
                                  child: CircleAvatar(
                                    radius: 30,
                                    child: CircleAvatar(


                                      radius: 28,
                                      backgroundImage: NetworkImage("https://tse2.mm.bing.net/th/id/OIP.TNdzNQyN3tmkgc2CrreK0QHaEJ?pid=Api&P=0&h=220"),
                                    ),
                                  ),
                                )]),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width:130,
                                    height: 26,
                                    child: Html(
                                      data: mapSearchViewModel.highlightedList[index]['_highlightResult']?['name']?['value'] ?? resturent.Name,
                                      style: {
                                        "body":Style(fontSize:FontSize(14),fontWeight:FontWeight.w600,color: Colors.black),
                                        "em":Style(backgroundColor: Colors.red,fontWeight:FontWeight.w800),
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 35,
                                    child: Chip(label: Text(resturent.Food_Type,style: TextStyle(color:Color.fromRGBO(
                                        9, 53, 1, 1.0),fontWeight: FontWeight.w700),),
                                      labelStyle: TextStyle(fontSize: 12),
                                      backgroundColor: Color.fromRGBO(130, 246, 136, 1.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50),
                                          side: BorderSide(color: Color.fromRGBO(
                                              19, 108, 3, 1.0))
                                      ),),
                                  )
                                ],
                              ),
                              SizedBox(height: 3,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    spacing:2,
                                    children: [
                                      Text("⭐"),
                                      Text(resturent.Stars_count.toString(),style: TextStyle(fontWeight: FontWeight.w700)),
                                      SizedBox(width: 2,),
                                      Text("(${resturent.Reviews_Count})",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.grey))
                                    ],
                                  ),
                                  Text("Price :${resturent.Price_Range}",style: TextStyle(fontWeight: FontWeight.w700),)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
                        })
                :Obx(() {
                  return mapSearchViewModel.SearchList.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: mapSearchViewModel.SearchList.length +(mapSearchViewModel.moreData.value && mapSearchViewModel.loadingData.value ? 1: 0),
                    itemBuilder: (context, index) {
                      if(index == mapSearchViewModel.SearchList.length){
                        return Obx(() =>mapSearchViewModel.loadingData.value ? Center(child: CircularProgressIndicator(),):SizedBox.shrink()
                        );
                      }
                      Resturents resturent = mapSearchViewModel.SearchList[index];
                      return Card(
                        child: Container(

                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 26,
                              backgroundImage:NetworkImage("https://tse2.mm.bing.net/th/id/OIP.TNdzNQyN3tmkgc2CrreK0QHaEJ?pid=Api&P=0&h=220"),
                            ),

                            title: Container(
                                width:220,
                                height: 30,
                                child: Html(
                                  data: mapSearchViewModel.highlightedList[index]['_highlightResult']?['name']?['value'] ?? resturent.Name,
                                  style: {
                                    "body":Style(fontSize:FontSize(13),fontWeight:FontWeight.w600,color: Colors.black),
                                    "em":Style(backgroundColor: Colors.red,fontWeight:FontWeight.w800),
                                  },
                                )),
                            subtitle: Row(
                              children: [
                                Text("⭐"),
                                Text(resturent.Stars_count.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13),),
                                SizedBox(width: 3,),
                                Text("(${resturent.Reviews_Count.toString()})",style: TextStyle(color:Colors.grey,fontSize: 13),),
                              ],
                            ),
                            trailing: Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    height:35,
                                    width:80,

                                    child: Chip(label: Text(resturent.Food_Type,),
                                      labelStyle: TextStyle(fontSize: 10,
                                          color: Color.fromRGBO(13, 161, 3, 0.9372549019607843),
                                          fontWeight: FontWeight.w700),
                                      backgroundColor: Color.fromRGBO(13, 161, 3, 0.1672549019607843),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(100),
                                          side: BorderSide(
                                            width: 2,
                                            color:Color.fromRGBO(13, 161, 3, 0.9372549019607843),
                                          )
                                      ),

                                    ),),
                                  SizedBox(width: 3,),

                                  Text("${resturent.Price_Range}")
                                ],
                              ),
                            ),

                          ),
                        ),
                      );
                    },
                  );
                })
          ],
        ),
      ),
    );
  }


}
