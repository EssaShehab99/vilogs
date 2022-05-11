import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/constant_values.dart';
import '../styles/colors_app.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {Key? key,
      required this.text,
      this.onTap,
      this.enable = true,
      this.keyButton,
      this.isLoading = false})
      : super(key: key);
  final String text;
  final GestureTapCallback? onTap;
  final bool enable;
  final bool isLoading;
  final Key? keyButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: ConstantValues.padding,
        left: ConstantValues.padding,
        right: ConstantValues.padding,
      ),
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: enable ? ColorsApp.primary : ColorsApp.grey,
          borderRadius: BorderRadius.circular(ConstantValues.radius)),
      child: InkWell(
        key: keyButton,
        onTap: enable ? (isLoading ? null : onTap) : null,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: isLoading
              ? CircularProgressIndicator(
                  color: ColorsApp.white,
                )
              : Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      ?.copyWith(color: ColorsApp.white),
                ),
        ),
      ),
    );
  }
}
