import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vilogs/constants/constant_values.dart';
import 'package:vilogs/modules/sign_in.dart';
import 'package:vilogs/modules/sign_up.dart';
import 'package:vilogs/shared/components.dart';
import 'package:vilogs/shared/custom_button.dart';
import 'package:vilogs/shared/text_input.dart';

import '../styles/colors_app.dart';

class NewPassword extends StatelessWidget {
  const NewPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    TextEditingController NewPasswordController = TextEditingController();

    List<TextEditingController> controllers =
        List<TextEditingController>.generate(
            4, (index) => TextEditingController());
    return Scaffold(
      body: Column(
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
                "app-name".tr(),
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    ?.copyWith(fontSize: 40),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: TextInput(
                            controller: passwordController,
                            labelText: "enter-new-password".tr(),
                            hint: "enter-password".tr(),
                          )),
                        Flexible(
                            child: TextInput(
                              controller: NewPasswordController,
                              labelText: "confirm-password".tr(),
                              hint: "confirm-password".tr(),
                            ))
                      ],
                    )),
                    Flexible(
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          margin:
                              EdgeInsets.only(bottom: ConstantValues.padding),
                          child: CustomButton(
                            text: "send".tr(),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
