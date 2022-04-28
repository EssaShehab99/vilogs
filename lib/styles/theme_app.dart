import 'package:flutter/material.dart';
import '/styles/colors_app.dart';

class ThemeApp{
static  ThemeData light=ThemeData(
    fontFamily: "Cairo",
    primaryColor: ColorsApp.primary,
    indicatorColor: ColorsApp.primary,
    textTheme:TextTheme(
      headline1: TextStyle(fontWeight: FontWeight.w800,fontSize: 18,color: ColorsApp.primary),
      bodyText1: TextStyle(fontWeight: FontWeight.w400,fontSize: 17,color: ColorsApp.primary),
    )
  );
}