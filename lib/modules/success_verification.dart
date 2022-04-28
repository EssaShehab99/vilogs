import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vilogs/constants/constant_values.dart';
import 'package:vilogs/modules/Home.dart';
import 'package:vilogs/modules/sign_in.dart';
import 'package:vilogs/modules/sign_up.dart';
import 'package:vilogs/shared/components.dart';
import 'package:vilogs/shared/custom_button.dart';
import 'package:vilogs/shared/text_input.dart';

import '../styles/colors_app.dart';

class SuccessVerification extends StatelessWidget {
  const SuccessVerification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
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
                    "app-name".tr(),
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        ?.copyWith(fontSize: 40),
                  ),
                )),
            Expanded(
                child: Column(
              children: [
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ConstantValues.padding),
                        child: Text(
                          "success".tr(),
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              ?.copyWith(fontSize: 30),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Flexible(
                        child: Container(
                      child: Icon(
                        Icons.check_box_rounded,
                        size: 150,
                        color: Colors.green,
                      ),
                    )),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ConstantValues.padding),
                        child: Text(
                          "success-change-password".tr(),
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              ?.copyWith(fontSize: 30),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        margin: EdgeInsets.only(bottom: ConstantValues.padding),
                        child: CustomButton(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Home(),
                                ));
                          },
                          text: "go-sign".tr(),
                        ),
                      ),
                    ),
                  ],
                ))
              ],
            ))
          ],
        ),
      ),
    );
  }
}
