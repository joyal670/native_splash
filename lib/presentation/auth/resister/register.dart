// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:alot/presentation/utils/colors.dart';
import 'package:alot/presentation/utils/dims.dart';
import 'package:flutter/material.dart';

import '../../dashboard/dashboard.dart';
import '../../utils/common_widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 10),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  height30,
                  TextWidget(
                    title: "Register",
                    textStyle: TextStyle(
                        color: colorBlack,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),
                  height10,
                  TextWidget(
                    title:
                        "Signup to get complete access to post jobs, post ads etc.",
                    textStyle: TextStyle(
                        color: colorGrey,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                  height20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/images/google.png',
                          width: 20,
                          height: 20,
                        ),
                        label: TextWidget(
                            title: "Signup with Google",
                            textStyle: TextStyle()),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(colorRed)),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/images/facebook.png',
                          width: 20,
                          height: 20,
                        ),
                        label: TextWidget(
                            title: "Connect with\n Facebook",
                            textStyle: TextStyle()),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(colorBlueAccent)),
                      ),
                    ],
                  ),
                  height30,
                  Row(children: [
                    Expanded(child: Divider()),
                    width30,
                    TextWidget(
                      title: "Or with email",
                      textStyle: TextStyle(),
                    ),
                    width30,
                    Expanded(child: Divider()),
                  ]),
                  height25,
                  TextWidget(
                      title: "Name",
                      textStyle: TextStyle(
                          color: colorBlack, fontWeight: FontWeight.normal)),
                  height10,
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        constraints: BoxConstraints.expand(height: 50),
                        label: TextWidget(
                            title: "Enter your name", textStyle: TextStyle()),
                        labelStyle: TextStyle(
                            color: colorGrey, fontWeight: FontWeight.w500),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: colorGrey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: colorGrey)),
                        floatingLabelBehavior: FloatingLabelBehavior.never),
                    maxLines: 1,
                  ),
                  height10,
                  TextWidget(
                      title: "Email",
                      textStyle: TextStyle(
                          color: colorBlack, fontWeight: FontWeight.normal)),
                  height10,
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        constraints: BoxConstraints.expand(height: 50),
                        label: TextWidget(
                            title: "Enter your email address",
                            textStyle: TextStyle()),
                        labelStyle: TextStyle(
                            color: colorGrey, fontWeight: FontWeight.w500),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: colorGrey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: colorGrey)),
                        floatingLabelBehavior: FloatingLabelBehavior.never),
                    maxLines: 1,
                  ),
                  height10,
                  TextWidget(
                      title: "Mobile number",
                      textStyle: TextStyle(
                          color: colorBlack, fontWeight: FontWeight.normal)),
                  height10,
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        constraints: BoxConstraints.expand(height: 50),
                        label: TextWidget(
                            title: "Enter your mobile number",
                            textStyle: TextStyle()),
                        labelStyle: TextStyle(
                            color: colorGrey, fontWeight: FontWeight.w500),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: colorGrey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: colorGrey)),
                        floatingLabelBehavior: FloatingLabelBehavior.never),
                    maxLines: 1,
                  ),
                  height10,
                  TextWidget(
                      title: "Password",
                      textStyle: TextStyle(
                          color: colorBlack, fontWeight: FontWeight.normal)),
                  height10,
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    decoration: InputDecoration(
                        constraints: BoxConstraints.expand(height: 50),
                        label: TextWidget(
                            title: "Enter your password",
                            textStyle: TextStyle()),
                        labelStyle: TextStyle(
                            color: colorGrey, fontWeight: FontWeight.w500),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: colorGrey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: colorGrey)),
                        floatingLabelBehavior: FloatingLabelBehavior.never),
                    maxLines: 1,
                  ),
                  height10,
                  TextWidget(
                      title: "Confirm Password",
                      textStyle: TextStyle(
                          color: colorBlack, fontWeight: FontWeight.normal)),
                  height10,
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        constraints: BoxConstraints.expand(height: 50),
                        label: TextWidget(
                            title: "Confirm Password", textStyle: TextStyle()),
                        labelStyle: TextStyle(
                            color: colorGrey, fontWeight: FontWeight.w500),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: colorGrey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: colorGrey)),
                        floatingLabelBehavior: FloatingLabelBehavior.never),
                    maxLines: 1,
                  ),
                  height20,
                  Row(
                    children: [
                      Checkbox(value: false, onChanged: (newVal) {}),
                      RichText(
                        text: TextSpan(
                          text: "I accept the",
                          style: TextStyle(color: colorBlack, fontSize: 14),
                          children: [
                            TextSpan(
                                text: ' Terms & Conditions',
                                style: TextStyle(color: colorBlue)),
                            TextSpan(
                                text: ' and',
                                style: TextStyle(color: colorBlack)),
                            TextSpan(
                                text: ' Privacy Policy',
                                style: TextStyle(color: colorBlue)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  height20,
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return DashboardScreen();
                        }));
                      },
                      child: TextWidget(
                          title: "Submit",
                          textStyle: TextStyle(fontWeight: FontWeight.bold)),
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(colorBlue),
                      ),
                    ),
                  ),
                  height25,
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    TextWidget(
                      title: "Already have an Account?",
                      textStyle: TextStyle(
                        color: colorGrey,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    width5,
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: TextWidget(
                        title: "Sign in",
                        textStyle: TextStyle(
                            color: colorBlue, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ]),
                  height20
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
