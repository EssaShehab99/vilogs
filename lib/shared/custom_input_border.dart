import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/constant_values.dart';
import '../styles/colors_app.dart';

class CustomInputBorder extends StatelessWidget {
  CustomInputBorder({Key? key, required this.child, this.labelText})
      : super(key: key);
  final Widget child;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: ConstantValues.padding,
        left: ConstantValues.padding,
        right: ConstantValues.padding,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          if (labelText != null)
            Flexible(
                child: Text(
              labelText!,
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  ?.copyWith(fontSize: 17, fontWeight: FontWeight.w700),
            )),
          Flexible(
            child: child,
          ),
        ],
      ),
    );
  }
}
