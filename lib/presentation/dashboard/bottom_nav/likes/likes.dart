// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:alot/presentation/utils/colors.dart';
import 'package:alot/presentation/utils/dims.dart';
import 'package:flutter/material.dart';

class LikeScreen extends StatelessWidget {
  LikeScreen({super.key});

  List<OrderModel> data = [];

  @override
  Widget build(BuildContext context) {
    data.clear();
    data.add(OrderModel(
        icon: Icon(
          Icons.shop,
          color: colorBlue,
        ),
        status: "Order Received",
        date: "2nd March, 2023",
        statu: 0,
        image: "https://i.dummyjson.com/data/products/1/thumbnail.jpg",
        title: "Huawei P30"));

    data.add(OrderModel(
        icon: Icon(
          Icons.remove_circle,
          color: colorRed,
        ),
        status: "Order Cancelled",
        date: "10th Dec, 2023",
        statu: 1,
        image: "https://i.dummyjson.com/data/products/3/thumbnail.jpg",
        title: "Samsung Universe 9"));

    data.add(OrderModel(
        icon: Icon(
          Icons.share_arrival_time,
          color: colorGreen,
        ),
        status: "Ongoing",
        date: "Delivered by, 19th Sep, 2023",
        statu: 2,
        image: "https://i.dummyjson.com/data/products/5/thumbnail.jpg",
        title: "OPPOF19"));

    return Scaffold(
      backgroundColor: colorWhite,
      body: ListView.builder(
          itemBuilder: (context, index) {
            return Container(
                margin: EdgeInsets.all(10),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    color: colorpOBackground,
                    borderRadius: BorderRadius.circular(10)),
                child: Material(
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        ListTile(
                          leading: data[index].icon,
                          title: Text(
                            data[index].status,
                          ),
                          subtitle: Text(
                            data[index].date,
                          ),
                          trailing: Icon(Icons.arrow_right),
                        ),
                        Divider(),
                        height3,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            width10,
                            Image.network(
                              data[index].image,
                              width: 60,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                            width10,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[index].title,
                                ),
                                height4,
                                Row(
                                  children: [
                                    Text(
                                      'qty:',
                                      style: TextStyle(color: colorGrey),
                                    ),
                                    width5,
                                    Text(
                                      '1',
                                      style: TextStyle(color: colorBlack),
                                    ),
                                    width10,
                                    Text(
                                      'Color:',
                                      style: TextStyle(color: colorGrey),
                                    ),
                                    width5,
                                    Text(
                                      'Black',
                                      style: TextStyle(color: colorBlack),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        height5,
                        if (data[index].statu == 0)
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Column(
                              children: [
                                Divider(
                                  thickness: 1,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: () {},
                                        style: ButtonStyle(),
                                        child: Text("Cancel"),
                                      ),
                                    ),
                                    width25,
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: () {},
                                        style: ButtonStyle(),
                                        child: Text("Return?"),
                                      ),
                                    )
                                  ],
                                ),
                                height10
                              ],
                            ),
                          )
                        else if (data[index].statu == 1)
                          height3
                        else
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Column(
                              children: [
                                Divider(
                                  thickness: 1,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: () {},
                                        style: ButtonStyle(),
                                        child: Text("Cancel"),
                                      ),
                                    ),
                                    width25,
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: () {},
                                        style: ButtonStyle(),
                                        child: Text("Track"),
                                      ),
                                    )
                                  ],
                                ),
                                height10
                              ],
                            ),
                          )
                      ],
                    ),
                  ),
                ));
          },
          itemCount: data.length),
    );
  }
}

class OrderModel {
  final Icon icon;
  final String status;
  final String date;
  final int statu;
  final String image;
  final String title;

  OrderModel(
      {required this.icon,
      required this.status,
      required this.date,
      required this.statu,
      required this.image,
      required this.title});
}
