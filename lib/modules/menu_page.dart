import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vilogs/constants/constant_images.dart';
import 'package:vilogs/constants/constant_values.dart';
import 'package:vilogs/modules/assign-engineer.dart';
import 'package:vilogs/modules/realtime_data.dart';

import '../data/providers/navigation_bar_manager.dart';
import '../styles/colors_app.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  @override
  Widget build(BuildContext context) {
    NavigationBarManager barManager=Provider.of<NavigationBarManager>(context);

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 0,
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: ColorsApp.white, boxShadow: [
                BoxShadow(
                    color: ColorsApp.grey.withOpacity(0.5),
                    blurRadius: 4,
                    spreadRadius: 0.5,
                    offset: Offset(0, 5))
              ]),
              child: Text(
                "menu".tr(),
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    ?.copyWith(fontSize: 30),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      buildCard(
                        onTap: () {
                          barManager.onItemTapped(2);
                        },
                          image: ConstantImage.logo,
                          text: "history".tr(),
                          margin: EdgeInsetsDirectional.only(
                              start: ConstantValues.padding,
                              top: ConstantValues.padding * 1.5),
                          context: context),
                      SizedBox(
                        width: ConstantValues.padding,
                      ),
                      buildCard(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => RealtimeData(),));
                        },
                          image: ConstantImage.logo,
                          text: "realtime-data".tr(),
                          margin: EdgeInsetsDirectional.only(
                              end: ConstantValues.padding,
                              top: ConstantValues.padding * 1.5),
                          context: context),
                    ],
                  ),
                  Row(
                    children: [
                      buildCard(
                          onTap: () {
                            barManager.onItemTapped(1);
                          },
                          image: ConstantImage.logo,
                          text: "issues".tr(),
                          margin: EdgeInsetsDirectional.only(
                              start: ConstantValues.padding,
                              top: ConstantValues.padding),
                          context: context),
                      SizedBox(
                        width: ConstantValues.padding,
                      ),
                      buildCard(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AssignEngineer(),));

                          },
                          image: ConstantImage.logo,
                          text: "assign-engineer".tr(),
                          margin: EdgeInsetsDirectional.only(
                              end: ConstantValues.padding,
                              top: ConstantValues.padding),
                          context: context),
                    ],
                  ),
                  Row(
                    children: [
                      buildCard(
                          onTap: () {
                          },
                          image: ConstantImage.logo,
                          text: "edit-profile".tr(),
                          margin: EdgeInsetsDirectional.only(
                              start: ConstantValues.padding,
                              end: ConstantValues.padding * 0.5,
                              bottom: ConstantValues.padding * 0.5,
                              top: ConstantValues.padding),
                          context: context),
                      Flexible(child: Container())
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      );
  }

  Flexible buildCard(
      {String? text,
      required String image,
      EdgeInsetsGeometry? margin,
        GestureTapCallback? onTap,
      required BuildContext context}) {
    return Flexible(
      child: InkWell(
        splashColor: ColorsApp.white.withOpacity(0.0),
        highlightColor: ColorsApp.white.withOpacity(0.0),
        onTap: onTap,
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
      ),
    );
  }
}
