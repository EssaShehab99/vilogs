import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vilogs/constants/constant_values.dart';
import 'package:vilogs/modules/auth.dart';
import 'package:vilogs/modules/sign_in.dart';
import 'package:vilogs/modules/sign_up.dart';
import 'package:vilogs/shared/components.dart';
import 'package:vilogs/shared/custom_button.dart';
import 'package:vilogs/shared/text_input.dart';

import '../data/network/sign_up_dao.dart';
import '../data/providers/user_manager.dart';
import '../styles/colors_app.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({Key? key}) : super(key: key);

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  TextEditingController newPasswordController = TextEditingController();

  TextEditingController confirmNewPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool obscureText = true;
  bool isLoading = false;

  List<TextEditingController> controllers =
  List<TextEditingController>.generate(
      4, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                            child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: TextInput(
                                controller: newPasswordController,
                                labelText: "enter-new-password".tr(),
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
                              )),
                            Flexible(
                                child: TextInput(
                                  controller: confirmNewPasswordController,
                                  labelText: "confirm-password".tr(),
                                  hint: "confirm-password".tr(),
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
                                  textInputAction: TextInputAction.done,
                                  validator: (value) {
                                    if (value == null ||
                                        value.length < 8 ||
                                        value.isEmpty ||
                                        value != newPasswordController.text) {
                                      return 'not-match'.tr();
                                    }
                                    return null;
                                  },
                                ))
                          ],
                        )),
                        Flexible(
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              margin:
                                  EdgeInsets.only(bottom: ConstantValues.padding),
                              child: StatefulBuilder(
                                builder: (context, setState) =>CustomButton(
                                  isLoading: isLoading,
                                  text: "send".tr(),
                                  onTap: (){

                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      Provider.of<UserManager>(context, listen: false).setPassword(
                                        newPasswordController.text
                                      );
                                      Provider.of<SignUpDAO>(context, listen: false)
                                          .changePassword()
                                          .whenComplete((){
                                        isLoading = false;
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Auth(),
                                            ));

                                      });
                                    }

                                  },
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
