import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vilogs/data/models/user.dart';
import 'package:vilogs/data/network/sign_up_dao.dart';
import 'package:vilogs/data/providers/user_manager.dart';
import 'package:vilogs/modules/verification.dart';
import 'package:vilogs/shared/components.dart';
import 'package:vilogs/shared/custom_input_border.dart';
import 'package:vilogs/shared/date_input.dart';

import '../constants/constant_values.dart';
import '../shared/custom_button.dart';
import '../shared/dropdown_input.dart';
import '../shared/text_input.dart';
import 'package:email_validator/email_validator.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key, required this.tabController}) : super(key: key);
  final TabController tabController;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late String vehicleBrand;
  late String vehicleModel;
  late DateTime manufactureYear;
  bool accept = false;
  bool obscureText = true;
  bool isLoading = false;

  TypeCharacter typeCharacter = TypeCharacter.individual;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextInput(
                labelText: "full-name".tr(),
                controller: fullNameController,
                hint: "enter-full-name".tr(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'validate-value'.tr();
                  }
                  return null;
                },
              ),
              TextInput(
                labelText: "email".tr(),
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                hint: "enter-email".tr(),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !EmailValidator.validate(value)) {
                    return 'validate-value'.tr();
                  }
                  return null;
                },
              ),
              DropdownInput(
                labelText: "vehicle-brand".tr(),
                hint: "select".tr() + " ...",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'validate-value'.tr();
                  }
                  return null;
                },
                width: 30,
                items: [
                  "1",
                  "2",
                  "3",
                ],
                onChanged: (value) {
                  vehicleBrand = value;
                },
              ),
              DropdownInput(
                labelText: "vehicle-model".tr(),
                hint: "select".tr() + " ...",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'validate-value'.tr();
                  }
                  return null;
                },
                width: 30,
                items: [
                  "1",
                  "2",
                  "3",
                ],
                onChanged: (value) {
                  vehicleModel = value;
                },
              ),
              DateInput(
                labelText: "vehicle-years".tr(),
                onChanged: (value) {
                  manufactureYear = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'validate-value'.tr();
                  }
                  return null;
                },
                hint: "mm/dd/yyyy",
              ),
              TextInput(
                labelText: "password".tr(),
                controller: passwordController,
                obscureText: obscureText,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value == null || value.length < 8 || value.isEmpty) {
                    return 'weak-password'.tr();
                  }
                  return null;
                },
                suffixIcon: IconButton(
                    icon: Icon(
                        obscureText ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    }),
                hint: "enter-password".tr(),
              ),
              TextInput(
                labelText: "confirm-password".tr(),
                validator: (value) {
                  if (value == null ||
                      value.length < 8 ||
                      value.isEmpty ||
                      value != passwordController.text) {
                    return 'not-match'.tr();
                  }
                  return null;
                },
                obscureText: obscureText,
                suffixIcon: IconButton(
                    icon: Icon(
                        obscureText ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    }),
                keyboardType: TextInputType.visiblePassword,
                controller: confirmPasswordController,
                textInputAction: TextInputAction.done,
                hint: "confirm-password".tr(),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: ConstantValues.padding * 0.5,
                  right: ConstantValues.padding * 0.5,
                  top: ConstantValues.padding,
                ),
                child: Row(
                  children: [
                    Flexible(
                        child: RadioListTile<TypeCharacter>(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(
                              "individual".tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  ?.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                            ),
                            contentPadding: EdgeInsets.zero,
                            value: TypeCharacter.individual,
                            groupValue: typeCharacter,
                            onChanged: (TypeCharacter? value) {
                              setState(() {
                                typeCharacter = value!;
                              });
                            })),
                    Flexible(
                        child: RadioListTile<TypeCharacter>(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(
                              "engineer".tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  ?.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                            ),
                            contentPadding: EdgeInsets.zero,
                            value: TypeCharacter.engineer,
                            groupValue: typeCharacter,
                            onChanged: (TypeCharacter? value) {
                              setState(() {
                                typeCharacter = value!;
                              });
                            })),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: ConstantValues.padding * 0.5,
                  right: ConstantValues.padding * 0.5,
                  top: ConstantValues.padding,
                ),
                child: Row(
                  children: [
                    Flexible(
                      child: SizedBox(
                        width: 110,
                        child: CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          value: accept,
                          onChanged: (value) {
                            setState(() {
                              accept = value!;
                            });
                          },
                          title: Text(
                            "accept".tr(),
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                ?.copyWith(
                                    fontSize: 15, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: TextButton(
                          onPressed: () {},
                          child: FittedBox(
                            child: Text(
                              "term-policies".tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  ?.copyWith(
                                      fontSize: 15,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w600),
                            ),
                          )),
                    )
                  ],
                ),
              ),
              StatefulBuilder(
                builder: (context, setState) => CustomButton(
                  enable: accept,
                  isLoading: isLoading,
                  text: "sign-up".tr(),
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      Provider.of<UserManager>(context, listen: false).setUser(
                          User(
                              name: fullNameController.text,
                              email: emailController.text,
                              vehicleBrand: vehicleBrand,
                              manufactureYear: manufactureYear,
                              vehicleModel: vehicleModel,
                              password: passwordController.text,
                              typeCharacter: typeCharacter));
                      Provider.of<SignUpDAO>(context, listen: false)
                          .sendOtp(context)
                          .then((value) {
                        if (value) {
                          isLoading = false;
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Verification(),
                              ));
                        } else {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: ConstantValues.padding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("have-account".tr() + " ",
                        style: Theme.of(context).textTheme.headline1?.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                    TextButton(
                      onPressed: () {
                        widget.tabController.animateTo(0);
                      },
                      child: Text("sign-in".tr(),
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              ?.copyWith(
                                  fontSize: 15,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
