import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vilogs/constants/constant_values.dart';
import 'package:vilogs/modules/reset_password.dart';
import 'package:vilogs/shared/components.dart';
import 'package:vilogs/shared/custom_button.dart';
import 'package:vilogs/shared/text_input.dart';
import 'package:vilogs/styles/colors_app.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key,required this.tabController}) : super(key: key);
  final TabController tabController;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool obscureText = true;
  bool? isRemember = true;

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextInput(
              labelText: "email".tr(),
              controller: emailController,
              hint: "enter-email".tr(),
            ),
            TextInput(
              labelText: "password".tr(),
              controller: passwordController,
              hint: "enter-password".tr(),
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
                          isRemember=value;
                        });
                      },
                      title: Text(
                        "remember_me".tr(),
                        style: Theme.of(context).textTheme.headline1?.copyWith(
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
            CustomButton(text: "sign-in".tr(),onTap: (){
              print("ggggggggggggggg");
            },),
            Padding(
              padding: EdgeInsets.symmetric(vertical: ConstantValues.padding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("not-account".tr()+" ",style: Theme.of(context).textTheme.headline1?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
                  TextButton(
                    onPressed: (){
                      widget.tabController.animateTo(1);
                    },
                    child: Text("sign-up".tr(),style: Theme.of(context).textTheme.headline1?.copyWith(
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
    );
  }
}
