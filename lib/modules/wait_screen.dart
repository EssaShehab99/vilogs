import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vilogs/constants/constant_images.dart';
import 'package:vilogs/constants/constant_values.dart';

import '../styles/colors_app.dart';

class WaitScreen extends StatelessWidget {
  const WaitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ConstantValues.padding),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(ConstantImage.logo),
          SizedBox(height: 100,),
          CircularProgressIndicator(
            color: ColorsApp.primary,
          ),
          SizedBox(height: 100,),
          Text("please-wait".tr(),style: Theme.of(context).textTheme.headline1,textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}
