// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:alot/presentation/notification/notification.dart';
import 'package:alot/presentation/utils/dims.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../order/address.dart';
import '../../../utils/colors.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      // bottomNavigationBar: Row(
      //   children: [
      //     width10,
      //     TextButton(
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //       style: ButtonStyle(
      //           backgroundColor: MaterialStatePropertyAll(colorpOBackground),
      //           padding: MaterialStateProperty.all(
      //               EdgeInsets.only(left: 20, right: 20))),
      //       child: Text('Sign out'),
      //     ),
      //   ],
      // ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            height15,
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: colorBlack),
                          shape: BoxShape.circle,
                          color: colorAmber),
                      child: Image.asset(
                        "assets/images/businessman.png",
                        width: 100,
                        height: 100,
                      )),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Joined',
                        style: TextStyle(
                            color: colorGrey, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        '1 year ago',
                        style: TextStyle(
                            color: colorBlack,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )
                    ],
                  ),
                )
              ],
            ),
            height15,
            Text(
              'David',
              style: TextStyle(
                  color: colorBlack, fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Text(
              'Robinson',
              style: TextStyle(
                  color: colorGrey, fontWeight: FontWeight.w300, fontSize: 30),
            ),
            height50,
            Text(
              'Profile',
              style: TextStyle(
                  color: colorBlack, fontWeight: FontWeight.bold, fontSize: 17),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                leading: Icon(
                  Icons.account_circle,
                  size: 30,
                  color: Colors.orange,
                ),
                title: Text(
                  'Manage account',
                  style: TextStyle(
                      color: colorBlack,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                trailing: Icon(
                  Icons.arrow_right,
                  size: 30,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                leading: Icon(
                  Icons.favorite,
                  size: 30,
                  color: colorRed,
                ),
                title: Text(
                  'favourites',
                  style: TextStyle(
                      color: colorBlack,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                trailing: Icon(
                  Icons.arrow_right,
                  size: 30,
                ),
              ),
            ),
            height30,
            Text(
              'Settings',
              style: TextStyle(
                  color: colorBlack, fontWeight: FontWeight.bold, fontSize: 17),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return NotificationScreen();
                }));
              },
              child: ListTile(
                leading: Icon(
                  Icons.notifications,
                  size: 30,
                  color: colorBlue,
                ),
                title: Text(
                  'Notifications',
                  style: TextStyle(
                      color: colorBlack,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                trailing: Icon(
                  Icons.arrow_right,
                  size: 30,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return AddressListing();
                }));
              },
              child: ListTile(
                leading: Icon(
                  Icons.pin_drop,
                  size: 30,
                  color: colorGreen,
                ),
                title: Text(
                  'Delivery Address',
                  style: TextStyle(
                      color: colorBlack,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                trailing: Icon(
                  Icons.arrow_right,
                  size: 30,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                // Navigator.pop(context);
                showPop(context);
              },
              child: ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  size: 30,
                  color: colorRed,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                      color: colorBlack,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                trailing: Icon(
                  Icons.arrow_right,
                  size: 30,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showPop(BuildContext context) {
    showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext buildContext) => CupertinoAlertDialog(
        title: Text("Logout"),
        content: Text("Are you sure want to logout"),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(buildContext);
            },
            isDefaultAction: true,
            child: Text("Cancel"),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(buildContext);
              Navigator.pop(context);
            },
            child: Text("Logout"),
          )
        ],
      ),
    );
  }
}
