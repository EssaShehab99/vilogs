import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vilogs/constants/constant_values.dart';
import 'package:vilogs/data/models/user.dart';
import 'package:vilogs/modules/new_password.dart';
import 'package:vilogs/modules/sign_in.dart';
import 'package:vilogs/modules/sign_up.dart';
import 'package:vilogs/modules/verification.dart';
import 'package:vilogs/shared/components.dart';
import 'package:vilogs/shared/custom_button.dart';
import 'package:vilogs/shared/text_input.dart';

import '../data/network/sign_in_dao.dart';
import '../data/network/sign_up_dao.dart';
import '../data/providers/user_manager.dart';
import '../styles/colors_app.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    bool? isLoading = false;
    final emailController = TextEditingController();
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
                          child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                                child: SizedBox(
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
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    !EmailValidator.validate(value)) {
                                  return 'validate-value'.tr();
                                }
                                return null;
                              },
                              labelText: "email".tr(),
                              hint: "enter-email".tr(),
                            ))
                          ],
                        ),
                      )),
                      Expanded(
                          flex: 0,
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            margin:
                                EdgeInsets.only(bottom: ConstantValues.padding),
                            child: StatefulBuilder(
                              builder: (context, setState) => Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (isLoading == null)
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: ConstantValues.padding),
                                        child: Text(
                                          "incorrect-email".tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1
                                              ?.copyWith(
                                                  color: Colors.red,
                                                  fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  CustomButton(
                                    text: "send".tr(),
                                    isLoading: isLoading ?? false,
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          isLoading = true;
                                          Provider.of<UserManager>(context,
                                                  listen: false)
                                              .setUser(User(
                                                  email: emailController.text));
                                          Provider.of<SignUpDAO>(context,
                                                  listen: false)
                                              .resetPassword()
                                              .then((value) {
                                            if (value) {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        Verification(
                                                            typeOperation:
                                                                TypeOperation
                                                                    .RESET_PASSWORD),
                                                  ));
                                            } else {
                                              setState(() {
                                                isLoading = null;
                                              });
                                            }
                                          });
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
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
