import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vilogs/constants/constant_values.dart';
import 'package:vilogs/modules/sign_in.dart';
import 'package:vilogs/modules/sign_up.dart';
import 'package:vilogs/modules/verification.dart';
import 'package:vilogs/shared/components.dart';
import 'package:vilogs/shared/custom_button.dart';
import 'package:vilogs/shared/text_input.dart';

import '../styles/colors_app.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();

    List<TextEditingController> controllers =
        List<TextEditingController>.generate(
            4, (index) => TextEditingController());
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(child: SizedBox(
                            height: 20,
                          )),
                          Flexible(
                            child: Text(
                              "reset-password".tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  ?.copyWith(fontSize: 23),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Flexible(
                              flex: 2,
                              child: Icon(
                                Icons.lock_reset,
                                color: ColorsApp.primary,
                                size: 200,
                              )),
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: ConstantValues.padding),
                              child: Text(
                                "enter-to-reset".tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    ?.copyWith(fontSize: 23),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Flexible(
                              child: TextInput(
                            controller: passwordController,
                            labelText: "email".tr(),
                            hint: "enter-email".tr(),
                          ))
                        ],
                      )),
                      Expanded(
                          flex: 0,
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            margin:
                                EdgeInsets.only(bottom: ConstantValues.padding),
                            child: CustomButton(
                              text: "send".tr(),
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Verification(),
                                    ));
                              },
                            ),
                          ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
