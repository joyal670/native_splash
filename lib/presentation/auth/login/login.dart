// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:alot/domain/repository/repository.dart';
import 'package:alot/presentation/auth/resister/register.dart';
import 'package:alot/presentation/utils/Responsive%20.dart';
import 'package:alot/presentation/utils/colors.dart';
import 'package:alot/presentation/utils/dims.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../../dashboard/dashboard.dart';
import '../../utils/common_widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Responsive.isMobile(context) ? mobileWidget() : desktopWidget(),
      ),
    );
  }
}

class desktopWidget extends StatelessWidget {
  const desktopWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 10),
      child: Center(
        child: SingleChildScrollView(
          child: Row(
            children: [
              width25,
              Expanded(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/footer_ogo.png',
                      width: 400,
                    )
                  ],
                ),
              ),
              width40,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text(AppLocalizations.of(context)!.hello.toString()),
                    TextWidget(
                      title: "Welcome back!",
                      textStyle: TextStyle(
                          color: colorBlue,
                          fontSize: Responsive.isMobile(context) ? 18 : 17,
                          fontWeight: FontWeight.w500),
                    ),
                    height5,
                    TextWidget(
                      title: "Member Login",
                      textStyle: TextStyle(
                          color: colorBlack,
                          fontSize: Responsive.isMobile(context) ? 24 : 34,
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
                            title: "Signup with Google",
                            textStyle: TextStyle()),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(colorRed)),
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
                          FocusManager.instance.primaryFocus?.unfocus();
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
            ],
          ),
        ),
      ),
    );
  }
}

class mobileWidget extends StatefulWidget {
  mobileWidget({
    super.key,
  });

  @override
  State<mobileWidget> createState() => _mobileWidgetState();
}

class _mobileWidgetState extends State<mobileWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userNameController = TextEditingController(text: 'kminchelle');
    final passwordController = TextEditingController(text: '0lelplR');

    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 10),
      child: Form(
        key: _formKey,
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter username';
                    }
                    return null;
                  },
                  controller: userNameController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      // constraints: BoxConstraints.expand(height: 50),
                      constraints:
                          const BoxConstraints(maxHeight: 70, minHeight: 35),
                      label: TextWidget(
                          title: "Default username kminchelle",
                          textStyle: TextStyle()),
                      labelStyle: TextStyle(
                          color: colorGrey, fontWeight: FontWeight.w500),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: colorGrey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: colorGrey)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: colorRed)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: colorRed)),
                      border: OutlineInputBorder(
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                  controller: passwordController,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      // constraints: BoxConstraints.expand(height: 50),
                      constraints:
                          const BoxConstraints(maxHeight: 70, minHeight: 35),
                      label: TextWidget(
                          title: "Default password 0lelplR",
                          textStyle: TextStyle()),
                      labelStyle: TextStyle(
                          color: colorGrey, fontWeight: FontWeight.w500),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: colorGrey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: colorGrey)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: colorRed)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: colorRed)),
                      border: OutlineInputBorder(
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final result = await Repository.instance.login(
                            userNameController.text, passwordController.text);

                        result.fold((l) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(l.message),
                          ));
                        }, (r) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("successfully logged in"),
                          ));
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return DashboardScreen();
                          }));
                        });
                      }
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
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      final data = await signInWithGoogle();
                      print(data);
                    },
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
                    onPressed: () async {
                      await signInWithFacebook();
                    },
                    icon: Image.asset(
                      'assets/images/facebook.png',
                      width: 20,
                      height: 20,
                    ),
                    label: TextWidget(
                        title: "Connect with Facebook", textStyle: TextStyle()),
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
                      FocusManager.instance.primaryFocus?.unfocus();
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
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
            clientId:
                '190564077554-c0cbmackem3i441ss2c8vuk8gv5ofcat.apps.googleusercontent.com')
        .signIn();

    if (googleUser == null) {
      // Handle the case where the user canceled the Google Sign-In process.
      return Future.error('Google Sign-In was canceled.');
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Check if at least one of ID token and access token is present
    if (googleAuth?.accessToken == null && googleAuth?.idToken == null) {
      // Handle the case where both tokens are null.
      return Future.error('Both access token and ID token are null.');
    }

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}
