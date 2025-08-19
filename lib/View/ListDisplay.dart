import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../ViewModel/ResturentListViewModel.dart';
import '../models/Resturents.dart';

class ListDisplay extends GetView<ResturentListViewModel> {
  Resturents resturent;
  int index;


  ListDisplay(this.resturent, this.index);

  @override
  Widget build(BuildContext context) {
    return Card(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  children:[ CircleAvatar(
                    radius: 26,
                    backgroundImage: NetworkImage(
                      "https://tse2.mm.bing.net/th/id/OIP.TNdzNQyN3tmkgc2CrreK0QHaEJ?pid=Api&P=0&h=220",
                    ),
                  ),
                
                   Expanded(
                     child: Column(
                       children:[
                       Html(
                        data:
                            controller.highlightedList[index]['_highlightResult']?['name']?['value'] ??
                            resturent.Name,
                        style: {
                          "body": Style(
                            fontSize: FontSize(13),
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          "em": Style(
                            backgroundColor: Colors.red,
                            fontWeight: FontWeight.w800,
                          ),
                        },
                      ),
                  Row(
                    children: [
                      Text("⭐"),
                      Text(
                        resturent.Stars_count.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(width: 3),
                      Text(
                        "(${resturent.Reviews_Count.toString()})",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  )])),
                   Column(
                    children: [
                      Chip(
                        label: Text(resturent.Food_Type),
                        labelStyle: TextStyle(
                          fontSize: 10,
                          color: Color.fromRGBO(
                            13,
                            161,
                            3,
                            0.9372549019607843,
                          ),
                          fontWeight: FontWeight.w700,
                        ),
                        backgroundColor: Color.fromRGBO(
                          13,
                          161,
                          3,
                          0.1672549019607843,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(100),
                          side: BorderSide(
                            width: 2,
                            color: Color.fromRGBO(
                              13,
                              161,
                              3,
                              0.9372549019607843,
                            ),
                          ),
                        ),
                      ),
                      Text("${resturent.Price_Range}"),
                    ],
                  ),
                             ] ),
              ),);

  }
}
