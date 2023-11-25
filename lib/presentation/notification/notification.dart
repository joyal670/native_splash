// ignore_for_file: prefer_const_constructors

import 'package:alot/presentation/utils/colors.dart';
import 'package:alot/presentation/utils/dims.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationModel> model = [];

  @override
  void initState() {
    model.clear();
    model.add(NotificationModel(
        title: "Hey David",
        desc:
            "Create an account and unlock free shipping for your first two orders. Sign up now!",
        isRead: false));
    model.add(NotificationModel(
        title: "Offer Code",
        desc:
            "Alex can receive an offer code ‘ALEX20′ for a 20% discount on their first purchase.",
        isRead: true));
    model.add(NotificationModel(
        title: "Hello",
        desc: "This is the new fad! Have you gotten yours yet? Order now!",
        isRead: false));
    model.add(NotificationModel(
        title: "Hey David",
        desc:
            "Create an account and unlock free shipping for your first two orders. Sign up now!",
        isRead: false));
    model.add(NotificationModel(
        title: "Offer Code",
        desc:
            "Alex can receive an offer code ‘ALEX20′ for a 20% discount on their first purchase.",
        isRead: false));
    model.add(NotificationModel(
        title: "Hello",
        desc: "This is the new fad! Have you gotten yours yet? Order now!",
        isRead: false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: colorpOBackground,
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: colorBlue,
            )),
        iconTheme: IconThemeData(
          color: colorBlack, //change your color here
        ),
        elevation: 0,
        title: Text(
          'Notifications',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: colorBlack),
          textAlign: TextAlign.center,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return InkWell(
            onTap: () {
              setState(() {
                model[index].isRead = true;
              });
            },
            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: model[index].isRead
                      ? colorpOBackground
                      : colorGreen.withOpacity(.05),
                  borderRadius: BorderRadius.circular(10)),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model[index].title,
                        style: TextStyle(
                            color: colorBlack,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      height5,
                      Text(
                        model[index].desc,
                        style: TextStyle(color: colorGrey, fontSize: 12),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 7,
                      width: 7,
                      decoration: BoxDecoration(
                        color: model[index].isRead ? colorGrey : colorRed,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: model.length,
      ),
    );
  }
}

class NotificationModel {
  String title;
  String desc;
  bool isRead;

  NotificationModel(
      {required this.title, required this.desc, required this.isRead});
}
