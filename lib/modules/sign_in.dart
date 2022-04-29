import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vilogs/constants/constant_values.dart';
import 'package:vilogs/data/network/sign_in_dao.dart';
import 'package:vilogs/data/providers/user_manager.dart';
import 'package:vilogs/modules/reset_password.dart';
import 'package:vilogs/shared/custom_button.dart';
import 'package:vilogs/shared/text_input.dart';
import 'package:vilogs/styles/colors_app.dart';

import '../data/setting/config.dart';
import 'Home.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key, required this.tabController}) : super(key: key);
  final TabController tabController;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool obscureText = true;
  bool isRemember = true;
  bool? isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
              TextInput(
                labelText: "password".tr(),
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                hint: "enter-password".tr(),
                validator: (value) {
                  if (value == null || value.length < 8 || value.isEmpty) {
                    return 'weak-password'.tr();
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
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                        value: isRemember,
                        onChanged: (value) {
                          setState(() {
                            isRemember = value!;
                          });
                        },
                        title: Text(
                          "remember_me".tr(),
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              ?.copyWith(
                                  fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Row(children: [
                        Icon(Icons.lock, color: ColorsApp.grey),
                        Flexible(
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ResetPassword(),
                                    ));
                              },
                              child: FittedBox(
                                child: Text(
                                  "forgot_password".tr(),
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
                      ]),
                    ),
                  ],
                ),
              ),
              StatefulBuilder(
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
                            "incorrect-data".tr(),
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                ?.copyWith(color: Colors.red, fontSize: 15),
                          ),
                        ),
                      ),
                    CustomButton(
                      isLoading: isLoading ?? false,
                      text: "sign-in".tr(),
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                            Provider.of<SignInDAO>(context, listen: false)
                                .signIn(emailController.text,
                                    passwordController.text)
                                .then((value) {
                              if (value != null) {
                                Provider.of<UserManager>(context, listen: false)
                                    .setUser(value);
                                if (isRemember)
                                  Config.setUser(emailController.text,
                                      passwordController.text);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Home(),
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: ConstantValues.padding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("not-account".tr() + " ",
                        style: Theme.of(context).textTheme.headline1?.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                    TextButton(
                      onPressed: () {
                        widget.tabController.animateTo(1);
                      },
                      child: Text("sign-up".tr(),
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
