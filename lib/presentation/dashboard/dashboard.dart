// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:alot/presentation/dashboard/bottom_nav/account/account.dart';
import 'package:alot/presentation/dashboard/bottom_nav/cart/cart.dart';
import 'package:alot/presentation/notification/notification.dart';
import 'package:alot/presentation/utils/colors.dart';
import 'package:alot/presentation/utils/dims.dart';
import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../providers/LocaleProvider.dart';
import '../utils/Responsive .dart';
import '../utils/common_widgets.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'bottom_nav/home/homescreen.dart';
import 'bottom_nav/likes/likes.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var _currentIndex = 0;
  final _pages = [
    HomeScreen(),
    LikeScreen(),
    CartScreen(
      isHomeScreen: true,
    ),
    AccountScreen()
  ];
  bool isShown = true;

  /// Shows the child widget if it is currently hidden.
  void show() {
    if (!isShown) {
      setState(() => isShown = true);
    }
  }

  /// Hides the child widget if it is currently shown.
  void hide() {
    if (isShown) {
      setState(
        () => isShown = false,
      );
    }
  }

  void listen() {
    final direction = scrollController.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      show();
    } else if (direction == ScrollDirection.reverse) {
      hide();
    }
  }

  @override
  void initState() {
    scrollController.addListener(listen);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorWhite,
        appBar: PreferredSize(
          preferredSize: isShown ? Size.fromHeight(100) : Size.fromHeight(0),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: isShown ? 80 : 0,
            child: AppBar(
              backgroundColor: colorWhite,
              elevation: 0,
              leading: Builder(builder: (context) {
                return InkWell(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(13),
                    child: Image.asset(
                      'assets/images/menu.png',
                    ),
                  ),
                );
              }),

              actions: [
                InkWell(
                  onTap: () {
                    if (_currentIndex != 2) {
                      setState(() => _currentIndex = 2);
                    }
                  },
                  child: Image.asset(
                    'assets/images/shopping_cart.png',
                    width: 25,
                    height: 25,
                  ),
                ),
                width15,
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return NotificationScreen();
                    }));
                  },
                  child: ShakeAnimatedWidget(
                    enabled: true,
                    duration: Duration(milliseconds: 1500),
                    shakeAngle: Rotation.deg(z: 40),
                    curve: Curves.linear,
                    child: Icon(
                      Icons.notifications_active,
                      color: colorRed,
                    ),
                  ),
                ),
                width20
              ],
              // leadingWidth: 35,
            ),
          ),
        ),
        bottomNavigationBar: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: isShown ? 60 : 0,
          child: SalomonBottomBar(
            currentIndex: _currentIndex,
            onTap: (i) => setState(() => _currentIndex = i),
            items: [
              /// Home
              SalomonBottomBarItem(
                icon: Icon(Icons.home),
                title: Text("Home"),
                selectedColor: Colors.purple,
              ),

              /// Likes
              SalomonBottomBarItem(
                icon: Icon(Icons.history),
                title: Text("Orders"),
                selectedColor: Colors.pink,
              ),

              /// Search
              SalomonBottomBarItem(
                icon: Icon(Icons.shopping_bag),
                title: Text("Cart"),
                selectedColor: Colors.orange,
              ),

              /// Profile
              SalomonBottomBarItem(
                icon: Icon(Icons.person),
                title: Text("Profile"),
                selectedColor: Colors.teal,
              ),
            ],
          ),
        ),
        drawer: DrawerWidget(),
        body: _pages[_currentIndex]);
  }
}

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: Responsive.isMobile(context) ? null : 500,
      backgroundColor: colorWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LocaleSwitcherWidget(),
          Padding(
            padding: const EdgeInsets.only(top: 50, right: 20),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.close,
                size: 30,
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/footer_ogo.png",
                  width: 120,
                  height: 60,
                ),
                height15,
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return CartScreen(
                        isHomeScreen: true,
                      );
                    }));
                  },
                  child: TextWidget(
                      title: 'Jobs',
                      textStyle: TextStyle(fontWeight: FontWeight.bold)),
                ),
                height5,
                TextWidget(
                    title: "Classifieds",
                    textStyle: TextStyle(fontWeight: FontWeight.bold)),
                height5,
                TextWidget(
                    title: "Care",
                    textStyle: TextStyle(fontWeight: FontWeight.bold)),
                height5,
                TextWidget(
                    title: "Market",
                    textStyle: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: TextWidget(
                        title: "Login",
                        textStyle: TextStyle(fontWeight: FontWeight.bold)),
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(colorBlue),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: TextWidget(
                        title: "Sign in",
                        textStyle: TextStyle(fontWeight: FontWeight.bold)),
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(colorRed),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class LocaleSwitcherWidget extends StatelessWidget {
  const LocaleSwitcherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale;

    return DropdownButtonHideUnderline(
      child: DropdownButton(
        value: locale,
        icon: Container(width: 12),
        items: AppLocalizations.supportedLocales.map(
          (nextLocale) {
            return DropdownMenuItem(
              value: nextLocale,
              onTap: () {
                final provider =
                    Provider.of<LocaleProvider>(context, listen: false);

                provider.setLocale(nextLocale);
              },
              child: Center(
                child: Text(nextLocale.toString()),
              ),
            );
          },
        ).toList(),
        onChanged: (_) {},
      ),
    );
  }
}
