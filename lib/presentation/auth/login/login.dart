// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:alot/presentation/auth/resister/register.dart';
import 'package:alot/presentation/utils/colors.dart';
import 'package:alot/presentation/utils/dims.dart';
import 'package:flutter/material.dart';
import '../../dashboard/dashboard.dart';
import '../../utils/common_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                  // Text(AppLocalizations.of(context)!.hello.toString()),
                  TextWidget(
                    title: "Welcome back!",
                    textStyle: TextStyle(
                        color: colorBlue,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  height5,
                  TextWidget(
                    title: "Member Login",
                    textStyle: TextStyle(
                        color: colorBlack,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  height20,
                  TextWidget(
                      title: "Email Address",
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
                  height30,
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
                  height30,
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
                  height40,
                  TextWidget(
                      title: "Forgot Password?",
                      textStyle: TextStyle(
                          color: colorBlue, fontWeight: FontWeight.normal)),
                  height20,
                  Row(children: [
                    Expanded(child: Divider()),
                    width30,
                    TextWidget(
                      title: "or",
                      textStyle: TextStyle(),
                    ),
                    width30,
                    Expanded(child: Divider()),
                  ]),
                  height40,
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/images/google.png',
                        width: 20,
                        height: 20,
                      ),
                      label: TextWidget(
                          title: "Signup with Google", textStyle: TextStyle()),
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(colorRed)),
                    ),
                  ),
                  height10,
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/images/facebook.png',
                        width: 20,
                        height: 20,
                      ),
                      label: TextWidget(
                          title: "Connect with Facebook",
                          textStyle: TextStyle()),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(colorBlueAccent)),
                    ),
                  ),
                  height25,
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    TextWidget(
                      title: "Don't have an Account?",
                      textStyle: TextStyle(
                        color: colorGrey,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    width5,
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return RegisterScreen();
                        }));
                      },
                      child: TextWidget(
                        title: "Sign up",
                        textStyle: TextStyle(
                            color: colorBlue, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
