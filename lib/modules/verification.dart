import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';
import 'package:vilogs/constants/constant_values.dart';
import 'package:vilogs/modules/sign_in.dart';
import 'package:vilogs/modules/sign_up.dart';
import 'package:vilogs/modules/success_verification.dart';
import 'package:vilogs/shared/components.dart';
import 'package:vilogs/shared/custom_button.dart';
import 'package:vilogs/shared/text_input.dart';

import '../data/network/sign_up_dao.dart';
import '../data/setting/config.dart';
import '../styles/colors_app.dart';

class Verification extends StatelessWidget {
   Verification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    String? verificationCode;
    // Config.setVerification(false);
    Config.setVerification(true);
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ConstantValues.padding),
                        child: Text(
                          "one-time-password".tr(),
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              ?.copyWith(fontSize: 23),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Flexible(
                        child:  OtpTextField(
                          numberOfFields: 6,
                          borderColor: ColorsApp.border,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(ConstantValues.radius)),
                              borderSide: BorderSide(color: ColorsApp.border, width: 2.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: ColorsApp.primary, width: 2.0)),
                            contentPadding: EdgeInsets.all(10),
                          ),
                          showFieldAsBox: true,
                          onCodeChanged: (String code) {
                            if(verificationCode!=null)
                            verificationCode=verificationCode!+code;
                            else
                              verificationCode=code;
                          },
                          keyboardType: TextInputType.numberWithOptions(
                              signed: true),
                        ))
                  ],
                )),
                Expanded(
                    child: Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(bottom: ConstantValues.padding),
                  child: StatefulBuilder(
                    builder: (context, setState) => CustomButton(
                      isLoading: isLoading,
                      text: "enter".tr(),
                      onTap: () {
                        if (verificationCode != null&&verificationCode?.length==6)
                            setState(() {
                                isLoading = true;
                              Provider.of<SignUpDAO>(context, listen: false)
                                  .verifyEmail(verificationCode!)
                                  .then((value) {
                                if (value) {
                                  Config.setVerification(false);

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SuccessVerification(),
                                      ));
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              });
                            });

                      },
                    ),
                  ),
                ))
              ],
            ))
          ],
        ),
      ),
    );
  }
}
