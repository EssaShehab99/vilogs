import 'package:flutter/material.dart';
import '../constants/constant_values.dart';
import '../data/models/history.dart';
import '../styles/colors_app.dart';

class Components {
static  bool validateStructure(String value){
  String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}
static  Container defaultListTable(List<History> list, History item, BuildContext context) {
  return Container(
    height: 80,
    width: double.infinity,
    margin: EdgeInsets.symmetric(
        horizontal: ConstantValues.padding),
    padding: EdgeInsets.symmetric(
        horizontal: ConstantValues.padding),
    decoration: BoxDecoration(
        borderRadius: list.indexOf(item) == 0
            ? BorderRadius.vertical(
            top: Radius.circular(ConstantValues.radius * 4))
            : BorderRadius.zero,
        color: list
            .indexOf(item)
            .isEven
            ? ColorsApp.primary.withOpacity(0.5)
            : ColorsApp.white),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
            flex: 2,
            child: Text(
              item.key + ":",
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: ColorsApp.black,
                  fontWeight: FontWeight.bold),
            )),
        Flexible(
            child: Text(
              item.value,
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyText1,
            )),
      ],
    ),
  );
}
}

enum TypeOperation{
  ADD,
  EDIT,
  RESET_PASSWORD,
  CREATE_ACCOUNT
}