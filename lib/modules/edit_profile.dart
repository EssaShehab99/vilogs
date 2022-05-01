import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vilogs/constants/constant_images.dart';
import 'package:vilogs/data/network/sign_up_dao.dart';
import 'package:vilogs/data/setting/config.dart';
import 'package:vilogs/main.dart';
import 'package:vilogs/modules/wait_screen.dart';
import 'package:vilogs/shared/dropdown_input.dart';
import 'package:vilogs/shared/text_input.dart';

import '../constants/constant_values.dart';
import '../data/models/user.dart';
import '../data/network/default_data_dao.dart';
import '../data/network/sign_in_dao.dart';
import '../data/providers/default_data_manager.dart';
import '../data/providers/user_manager.dart';
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
  String? vehicleBrand;
  String? vehicleModel;
  String? manufactureYear;
  bool readOnlyName = true;
  bool readOnlyBrand = true;
  bool readOnlyModel = true;
  bool readOnlyYear = true;
  bool obscureText = true;
  bool isLoading = false;
  late UserManager userManager;

  @override
  void initState() {
    userManager = Provider.of<UserManager>(context, listen: false);
    Provider.of<DefaultDataDAO>(context, listen: false)
        .getData()
        .whenComplete(() {
      Provider.of<DefaultDataManager>(context, listen: false)
          .setCurrentVehicleBrand(userManager.getUser!.vehicleBrand!);

      Provider.of<DefaultDataManager>(context, listen: false)
          .setCurrentModel(userManager.getUser!.vehicleModel!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<DefaultDataManager>(builder: (context, value, _) {
        if (value.vehicleBrandList.isEmpty)
          return Scaffold(body: WaitScreen());
        else {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 0,
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration:
                        BoxDecoration(color: ColorsApp.white, boxShadow: [
                      BoxShadow(
                          color: ColorsApp.grey.withOpacity(0.5),
                          blurRadius: 4,
                          spreadRadius: 0.5,
                          offset: Offset(0, 5))
                    ]),
                    child: Row(
                      children: [
                        Flexible(
                            flex: 0,
                            child: Container(
                              padding: EdgeInsetsDirectional.only(
                                  start: ConstantValues.padding * 0.5),
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: ColorsApp.grey,
                                  )),
                            )),
                        Flexible(
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            margin: EdgeInsetsDirectional.only(
                                end: ConstantValues.padding * 2),
                            child: Text(
                              "edit-profile".tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  ?.copyWith(fontSize: 30),
                            ),
                          ),
                        ),
                      ],
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
                                  child: SvgPicture.asset(
                                      ConstantImage.editProfile),
                                ),
                                CircleAvatar(
                                  radius: 65.0,
                                  backgroundColor:
                                      ColorsApp.primary.withOpacity(0.0),
                                  child: Align(
                                    alignment: AlignmentDirectional.bottomEnd,
                                    child: InkWell(
                                      onTap: () {},
                                      splashColor:
                                          ColorsApp.white.withOpacity(0.0),
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
                            hint: userManager.getUser?.name,
                            readOnly: readOnlyName,
                            prefixIcon: buildEnableButton(
                                onTap: () {
                                  setState(() {
                                    readOnlyName = !readOnlyName;
                                    if (!readOnlyName)
                                      fullNameController =
                                          TextEditingController(
                                              text: userManager.getUser?.name);
                                    else
                                      fullNameController = null;
                                  });
                                },
                                readOnly: readOnlyName),
                            validator: (value) {
                              if ((value == null || value.isEmpty) &&
                                  !readOnlyName) {
                                return 'validate-value'.tr();
                              }
                              return null;
                            },
                          ),
                          TextInput(
                            labelText: "email".tr(),
                            controller: TextEditingController(),
                            keyboardType: TextInputType.emailAddress,
                            hint: userManager.getUser?.email,
                            readOnly: true,
                            prefixIcon: buildEnableButton(readOnly: true),
                          ),
                          DropdownInput(
                            labelText: "vehicle-brand".tr(),
                            hint: userManager.getUser?.vehicleBrand,
                            itemHeight: 50,
                            key: UniqueKey(),
                            keyDropDown: UniqueKey(),
                            defaultValue: vehicleBrand,
                            items: value.vehicleList(),
                            validator: (value) {
                              if ((value == null || value.isEmpty) &&
                                  !readOnlyBrand) {
                                return 'validate-value'.tr();
                              }
                              return null;
                            },
                            onChanged: (val) {
                              vehicleBrand = val;
                              vehicleModel = null;
                              value.setCurrentVehicleBrand(val);
                            },
                            width: 80,
                            readOnly: readOnlyBrand,
                            prefixIcon: buildEnableButton(
                                onTap: () {
                                  setState(() {
                                    readOnlyBrand = !readOnlyBrand;
                                  });
                                },
                                readOnly: readOnlyBrand),
                          ),
                          DropdownInput(
                            labelText: "vehicle-model".tr(),
                            hint: userManager.getUser?.vehicleModel,
                            itemHeight: 50,
                            key: UniqueKey(),
                            keyDropDown: UniqueKey(),
                            defaultValue: vehicleModel,
                            items: value.modelsList(),
                            validator: (value) {
                              if ((value == null || value.isEmpty) &&
                                  !readOnlyModel) {
                                return 'validate-value'.tr();
                              }
                              return null;
                            },
                            onChanged: (val) {
                              manufactureYear = null;
                              value.setCurrentModel(val);
                              vehicleModel = val;
                            },
                            width: 80,
                            readOnly: readOnlyModel,
                            prefixIcon: buildEnableButton(
                                onTap: () {
                                  setState(() {
                                    readOnlyModel = !readOnlyModel;
                                  });
                                },
                                readOnly: readOnlyModel),
                          ),
                          DropdownInput(
                            labelText: "vehicle-years".tr(),
                            hint: userManager.getUser?.manufactureYear,
                            itemHeight: 50,
                            key: UniqueKey(),
                            keyDropDown: UniqueKey(),
                            defaultValue: manufactureYear,
                            items: value.yearsList(),
                            validator: (value) {
                              if ((value == null || value.isEmpty) &&
                                  !readOnlyYear) {
                                return 'validate-value'.tr();
                              }
                              return null;
                            },
                            onChanged: (val) {
                              manufactureYear = val;
                            },
                            width: 80,
                            readOnly: readOnlyYear,
                            prefixIcon: buildEnableButton(
                                onTap: () {
                                  value.currentModel?.years.forEach((element) {
                                    print(
                                        "ttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt");
                                  });
                                  setState(() {
                                    readOnlyYear = !readOnlyYear;
                                  });
                                },
                                readOnly: readOnlyYear),
                          ),
                          Flexible(
                              child: Container(
                            alignment: Alignment.bottomCenter,
                            margin: EdgeInsets.symmetric(
                                vertical: ConstantValues.padding),
                            child: StatefulBuilder(
                              builder: (context, setState) => CustomButton(
                                isLoading: isLoading,
                                text: "save".tr(),
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    Provider.of<SignUpDAO>(context,
                                            listen: false)
                                        .updateUser(User(
                                      email: userManager.getUser?.email,
                                      name: fullNameController?.text ??
                                          userManager.getUser?.email,
                                      password: userManager.getUser?.password,
                                      typeCharacter:
                                          userManager.getUser?.typeCharacter,
                                      vehicleBrand: vehicleBrand ??
                                          userManager.getUser?.vehicleBrand,
                                      vehicleModel: vehicleModel ??
                                          userManager.getUser?.vehicleModel,
                                      manufactureYear: manufactureYear ??
                                          userManager.getUser?.manufactureYear,
                                    ))
                                        .whenComplete(() {
                                        Provider.of<SignInDAO>(context,
                                                listen: false)
                                            .signIn(userManager.getUser?.email,
                                                userManager.getUser?.password)
                                            .then((value) {
                                              if(value!=null)
                                              userManager.setUser(value);
                                          setState((){
                                            isLoading = false;
                                            Navigator.pop(context);
                                          });
                                        });

                                    });
                                  }
                                },
                              ),
                            ),
                          )),
                          Flexible(
                              child: Container(
                            alignment: Alignment.bottomCenter,
                            margin: EdgeInsets.symmetric(
                                vertical: ConstantValues.padding),
                            child: StatefulBuilder(
                              builder: (context, setState) => CustomButton(
                                isLoading: isLoading,
                                text: "logout".tr(),
                                onTap: () {
                                  Config.clearUser();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MyApp(user: null),
                                      ));
                                },
                              ),
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }
      }),
    );
  }

  InkWell buildEnableButton(
      {GestureTapCallback? onTap, required bool readOnly}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: ConstantValues.padding,
        decoration: BoxDecoration(
            border: BorderDirectional(end: BorderSide(color: ColorsApp.grey))),
        child: Icon(
          Icons.edit,
          color: readOnly ? ColorsApp.grey : Colors.blue,
        ),
      ),
    );
  }
}
