import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vilogs/constants/constant_images.dart';
import 'package:vilogs/constants/constant_values.dart';
import 'package:vilogs/data/providers/navigation_bar_manager.dart';

import '../styles/colors_app.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    NavigationBarManager barManager=Provider.of<NavigationBarManager>(context);
    return SafeArea(
      child: Scaffold(
        body: barManager.screens[barManager.selectedIndex],
        bottomNavigationBar: SizedBox(
          height: 70,
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(ConstantValues.radius * 4)),
            child: BottomNavigationBar(
              key: Key('bottom'),
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'home'.tr(),
tooltip: 'home'
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'issues'.tr(),
                    tooltip: 'issues'
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: 'history'.tr(),
                    tooltip: 'history'
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.view_list_sharp),
                  label: 'menu'.tr(),
                    tooltip: 'menu'
                ),
              ],
              type: BottomNavigationBarType.fixed,
              backgroundColor: ColorsApp.primary,
              currentIndex: barManager.selectedIndex,
              selectedItemColor: ColorsApp.white.withOpacity(0.5),
              onTap: barManager.onItemTapped,
              unselectedItemColor: ColorsApp.white,
            ),
          ),
        ),
      ),
    );
  }

  Flexible buildCard(
      {String? text,
      required String image,
      EdgeInsetsGeometry? margin,
      required BuildContext context}) {
    return Flexible(
      child: Container(
        width: double.infinity,
        height: 180,
        margin: margin,
        padding: EdgeInsets.all(ConstantValues.padding * 0.5),
        decoration: BoxDecoration(
            color: ColorsApp.white,
            borderRadius: BorderRadius.circular(ConstantValues.radius),
            boxShadow: [
              BoxShadow(color: ColorsApp.border, spreadRadius: 3, blurRadius: 5)
            ]),
        child: Column(
          children: [
            Flexible(flex: 2, child: SvgPicture.asset(image)),
            Flexible(
                child: Text(
              text ?? "",
              style: Theme.of(context).textTheme.headline1,
            ))
          ],
        ),
      ),
    );
  }
}
