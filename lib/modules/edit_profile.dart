import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vilogs/constants/constant_images.dart';
import 'package:vilogs/shared/dropdown_input.dart';
import 'package:vilogs/shared/text_input.dart';

import '../constants/constant_values.dart';
import '../shared/custom_button.dart';
import '../styles/colors_app.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? fullNameController;
  TextEditingController? emailController;
  String? vehicleBrand;
   String? vehicleModel;
   String? manufactureYear;

  bool obscureText = true;

  bool isLoading = false;

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
                  "edit-profile".tr(),
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      ?.copyWith(fontSize: 30),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: ConstantValues.padding,
                      ),
                      Flexible(
                          child: CircleAvatar(
                        radius: 69.0,
                        backgroundColor: ColorsApp.primary,
                        foregroundColor: ColorsApp.primary,
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 65.0,
                              backgroundColor: ColorsApp.white,
                              child:
                                  SvgPicture.asset(ConstantImage.editProfile),
                            ),
                            CircleAvatar(
                              radius: 65.0,
                              backgroundColor:
                                  ColorsApp.primary.withOpacity(0.0),
                              child: Align(
                                alignment: AlignmentDirectional.bottomEnd,
                                child: InkWell(
                                  onTap: () {},
                                  splashColor: ColorsApp.white.withOpacity(0.0),
                                  highlightColor:
                                      ColorsApp.white.withOpacity(0.0),
                                  child: CircleAvatar(
                                    backgroundColor:
                                        ColorsApp.primary.withOpacity(0.8),
                                    radius: 20.0,
                                    child: Icon(
                                      Icons.edit,
                                      size: 20.0,
                                      color: ColorsApp.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                      Flexible(
                          child: Text(
                        "profile-photo".tr(),
                        style: Theme.of(context)
                            .textTheme
                            .headline1
                            ?.copyWith(fontSize: 20),
                      )),
                      TextInput(
                        labelText: "full-name".tr(),
                        controller:
                            fullNameController ?? TextEditingController(),
                        hint: "enter-full-name".tr(),
                        readOnly: fullNameController == null ? true : false,
                        prefixIcon: InkWell(
                          onTap: () {
                            print(fullNameController);
                            setState(() {
                              fullNameController == null
                                  ? fullNameController = TextEditingController()
                                  : fullNameController =null;
                            });
                          },
                          child: Container(
                            width: ConstantValues.padding,
                            decoration: BoxDecoration(
                                border: BorderDirectional(
                                    end: BorderSide(color: ColorsApp.grey))),
                            child: Icon(Icons.edit,color: fullNameController == null
                                ? ColorsApp.grey
                                : Colors.blue,),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'validate-value'.tr();
                          }
                          return null;
                        },
                      ),
                      TextInput(
                        labelText: "email".tr(),
                        controller:
                        emailController ?? TextEditingController(),
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
                        readOnly: emailController == null ? true : false,
                        prefixIcon: InkWell(
                          onTap: () {
                            print(emailController);
                            setState(() {
                              emailController == null
                                  ? emailController = TextEditingController()
                                  : emailController =null;
                            });
                          },
                          child: Container(
                            width: ConstantValues.padding,
                            decoration: BoxDecoration(
                                border: BorderDirectional(
                                    end: BorderSide(color: ColorsApp.grey))),
                            child: Icon(Icons.edit,color: emailController == null
                                ? ColorsApp.grey
                                : Colors.blue,),
                          ),
                        ),
                      ),
                      DropdownInput(
                        labelText: "vehicle-brand".tr(),
                        defaultValue: "2",
                        itemHeight: 50,
                        items: [
                          "1",
                          "2",
                          "3",
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'validate-value'.tr();
                          }
                          return null;
                        },
                        width: 30,
                        readOnly: vehicleBrand == null ? true : false,
                        prefixIcon: InkWell(
                          onTap: () {
                            print(fullNameController);
                            setState(() {
                              vehicleBrand == null
                                  ? vehicleBrand = "2"
                                  : vehicleBrand =null;
                            });
                          },
                          child: Container(
                            width: ConstantValues.padding,
                            decoration: BoxDecoration(
                                border: BorderDirectional(
                                    end: BorderSide(color: ColorsApp.grey))),
                            child: Icon(Icons.edit,color: vehicleBrand == null
                                ? ColorsApp.grey
                                : Colors.blue,),
                          ),
                        ),
                      ),
                      DropdownInput(
                        labelText: "vehicle-model".tr(),
                        hint: "2",
                        itemHeight: 50,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'validate-value'.tr();
                          }
                          return null;
                        },
                        width: 30,
                        readOnly: vehicleModel == null ? true : false,
                        prefixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              vehicleModel == null
                                  ? vehicleModel = "2"
                                  : vehicleModel =null;
                            });
                          },
                          child: Container(
                            width: ConstantValues.padding,
                            decoration: BoxDecoration(
                                border: BorderDirectional(
                                    end: BorderSide(color: ColorsApp.grey))),
                            child: Icon(Icons.edit,color: vehicleModel == null
                                ? ColorsApp.grey
                                : Colors.blue,),
                          ),
                        ),
                      ),
                      DropdownInput(
                        labelText: "vehicle-years".tr(),
                        hint: "2",
                        itemHeight: 50,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'validate-value'.tr();
                          }
                          return null;
                        },
                        width: 30,
                        readOnly: manufactureYear == null ? true : false,
                        prefixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              manufactureYear == null
                                  ? manufactureYear = "2"
                                  : manufactureYear =null;
                            });
                          },
                          child: Container(
                            width: ConstantValues.padding,
                            decoration: BoxDecoration(
                                border: BorderDirectional(
                                    end: BorderSide(color: ColorsApp.grey))),
                            child: Icon(Icons.edit,color: manufactureYear == null
                                ? ColorsApp.grey
                                : Colors.blue,),
                          ),
                        ),
                      ),
                      Flexible(
                          child: Container(
                        alignment: Alignment.bottomCenter,
                        margin: EdgeInsets.symmetric(vertical: ConstantValues.padding),
                        child: StatefulBuilder(
                          builder: (context, setState) => CustomButton(
                            isLoading: isLoading,
                            text: "save".tr(),
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
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
            )
          ],
        ),
      ),
    );
  }
}
