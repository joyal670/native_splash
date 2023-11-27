// ignore_for_file: prefer_const_constructors

import 'package:alot/presentation/bloc/notification_bloc.dart';
import 'package:alot/presentation/utils/colors.dart';
import 'package:alot/presentation/utils/dims.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NotificationBloc>(context).add(
      GetNotification(),
    );

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
        body: BlocBuilder<NotificationBloc, NotificationBlocState>(
            builder: (context, state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemBuilder: (ctx, index) {
                return InkWell(
                  onTap: () {
                    // setState(() {
                    //   model[index].isRead = true;
                    // });

                    BlocProvider.of<NotificationBloc>(context).add(
                      OnClickNotification(index: index),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: state.data[index].isRead
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
                              state.data[index].title,
                              style: TextStyle(
                                  color: colorBlack,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            height5,
                            Text(
                              state.data[index].desc,
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
                              color: state.data[index].isRead
                                  ? colorGrey
                                  : colorRed,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: state.data.length,
            );
          }
        }));
  }
}

class NotificationModel {
  String title;
  String desc;
  bool isRead;

  NotificationModel(
      {required this.title, required this.desc, required this.isRead});
}
