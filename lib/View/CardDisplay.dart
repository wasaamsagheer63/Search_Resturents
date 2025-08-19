import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:service_provider_finder/ViewModel/ResturentListViewModel.dart';

import '../models/Resturents.dart';

class CardDisplay extends GetView<ResturentListViewModel> {
  Resturents resturent;
  int index;


  CardDisplay(this.resturent,this.index);

  @override
  Widget build(BuildContext context) {
    return  Card(
                  child: Column(
                    children: [
                      Container(
                        height:100,
                        child: Stack(
                          children: [
                            Container(
                              height: 85,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius:
                                BorderRadius.vertical(
                                  top: Radius.circular(
                                    10,
                                  ),
                                ),
                                child: Image.network(
                                  "https://tse1.mm.bing.net/th/id/OIP.aULahN1LnhlTmcuM_DptkAHaE9?pid=Api",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 42,
                              left: 20,
                              child: CircleAvatar(
                                radius: 30,
                                child: CircleAvatar(
                                  radius: 28,
                                  backgroundImage: NetworkImage(
                                    "https://tse2.mm.bing.net/th/id/OIP.TNdzNQyN3tmkgc2CrreK0QHaEJ?pid=Api&P=0&h=220",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 130,
                              height: 26,
                              child: Html(
                                data:
                                    controller.highlightedList[index]['_highlightResult']?['name']?['value'] ??
                                        resturent.Name,
                                style: {
                                  "body": Style(
                                    fontSize: FontSize(14),
                                    fontWeight:
                                    FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                  "em": Style(
                                    backgroundColor:
                                    Colors.green,
                                    fontWeight:
                                    FontWeight.w800,
                                  ),
                                },
                              ),
                            ),
                            Container(
                              height: 35,
                              child: Chip(
                                label: Text(
                                  resturent.Food_Type,
                                  style: TextStyle(
                                    color: Color.fromRGBO(
                                      9,
                                      53,
                                      1,
                                      1.0,
                                    ),
                                    fontWeight:
                                    FontWeight.w700,
                                  ),
                                ),
                                labelStyle: TextStyle(
                                  fontSize: 12,
                                ),
                                backgroundColor:
                                Color.fromRGBO(
                                  130,
                                  246,
                                  136,
                                  1.0,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(
                                    50,
                                  ),
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
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              spacing: 2,
                              children: [
                                Text("⭐"),
                                Text(

                                  resturent.Stars_count.toString(),
                                  style: TextStyle(
                                    fontWeight:
                                    FontWeight.w700,
                                  ),
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "(${resturent.Reviews_Count})",
                                  style: TextStyle(
                                    fontWeight:
                                    FontWeight.w700,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Price :${resturent.Price_Range}",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),);



  }

}
