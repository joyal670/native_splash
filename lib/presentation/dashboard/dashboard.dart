// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:alot/presentation/utils/colors.dart';
import 'package:alot/presentation/utils/dims.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../providers/LocaleProvider.dart';
import '../utils/common_widgets.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorBlue,
        leading: Builder(builder: (context) {
          return InkWell(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.all(13),
              child: Image.asset(
                'assets/images/hamburger_icon.png',
              ),
            ),
          );
        }),
        // leadingWidth: 35,
      ),
      drawer: Drawer(
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
                  TextWidget(
                      title: AppLocalizations.of(context)!.hello.toString(),
                      textStyle: TextStyle(fontWeight: FontWeight.bold)),
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
