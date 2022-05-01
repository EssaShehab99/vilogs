import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vilogs/constants/constant_images.dart';
import 'package:vilogs/constants/constant_values.dart';
import 'package:vilogs/data/models/enginner.dart';
import 'package:vilogs/data/providers/engineer_manager.dart';
import 'package:vilogs/shared/custom_button.dart';
import 'package:vilogs/shared/dropdown_input.dart';
import 'package:vilogs/shared/text_input.dart';

import '../data/network/default_data_dao.dart';
import '../styles/colors_app.dart';

class AssignEngineer extends StatefulWidget {
  const AssignEngineer({Key? key}) : super(key: key);

  @override
  State<AssignEngineer> createState() => _AssignEngineerState();
}

class _AssignEngineerState extends State<AssignEngineer> {
  final idController = TextEditingController();
 late EngineerManager engineerManager;
  @override
  Widget build(BuildContext context) {
    engineerManager=Provider.of<EngineerManager>(context, listen: false);
    Provider.of<DefaultDataDAO>(context, listen: false)
        .getEngineerData().then((value) {
      engineerManager.setEngineers(value);
    });
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 0,
              child: Container(
                decoration: BoxDecoration(color: ColorsApp.white, boxShadow: [
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
                          "assign-engineer".tr(),
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
                child: Consumer<EngineerManager>(
                  builder: (context, value, child) =>
                      Column(mainAxisSize: MainAxisSize.min, children: [
                    if (value.getCurrent().length != 0)
                      Flexible(
                          child: SizedBox(
                        height: ConstantValues.padding,
                      )),
                    if (value.getCurrent().length != 0)
                      Flexible(
                          child: Container(
                              padding: EdgeInsetsDirectional.only(
                                  start: ConstantValues.padding),
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                "current-engineer".tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    ?.copyWith(fontSize: 20),
                              ))),
                    for (Engineer item in value.getCurrent())
                      Flexible(child: buildCard(item)),
                    Flexible(
                        child: SizedBox(
                      height: ConstantValues.padding,
                    )),
                    Flexible(
                        child: Container(
                            padding: EdgeInsetsDirectional.only(
                                start: ConstantValues.padding),
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              "available-engineer".tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  ?.copyWith(fontSize: 20),
                            ))),
                    for (Engineer item in value.getAvailableEngineer())
                      Flexible(child: buildCard(item))
                  ]),
                ),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  contentPadding: EdgeInsets.zero,
                      content: Stack(                              alignment: Alignment.bottomCenter,

                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: ConstantValues.padding),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Center(
                                    child: Text(
                                  "assign-an-engineer".tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      ?.copyWith(fontSize: 20),
                                )),
                                SizedBox(
                                  height: 100,
                                  child: TextInput(
                                    paddingTop: false,
                                    labelText: "enter-engineer-id".tr(),
                                    hint: "enter-id".tr(),
                                    controller: idController,
                                  ),
                                ),
                                SizedBox(
                                  height: 100,
                                  child: DropdownInput(
                                    paddingTop: false,
                                    isDense: true,
                                    labelText: "choose-duration".tr(),
                                    hint: "duration".tr(),
                                    items: [
                                      "1",
                                      "2",
                                    ],
                                  ),
                                ),
                                SizedBox(height: ConstantValues.padding,)
                              ],
                            ),
                          ),
                          Transform.translate(offset: Offset(0,25),child:                                 SizedBox(
                              height: 70,
                              width: 160,
                              child: CustomButton(text: "assign".tr())))
                        ],
                      ),
                    ));
          },
          label: Text(
            "assign",
            style: Theme.of(context)
                .textTheme
                .headline1
                ?.copyWith(color: ColorsApp.white),
          ),
          icon: Icon(Icons.add),
          backgroundColor: ColorsApp.primary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
        ),
      ),
    );
  }

  Widget buildCard(Engineer engineer) => Stack(
        children: [
          Container(
            height: 180,
            margin: EdgeInsets.only(
                right: ConstantValues.padding,
                left: ConstantValues.padding,
                top: ConstantValues.padding),
            decoration: BoxDecoration(
                color: ColorsApp.primary.withOpacity(0.5),
                borderRadius: BorderRadius.circular(ConstantValues.radius * 4)),
            child: Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.all(ConstantValues.padding * 0.5),
                  child: CircleAvatar(
                    minRadius: 70,
                    child: Icon(Icons.account_circle_outlined, size: 70),
                  ),
                )),
                Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (List<Object?> item in [
                          ["name".tr(), engineer.name],
                          ["id".tr(), engineer.id],
                          [
                            "availability".tr(),
                            engineer.availability
                                ? "available".tr()
                                : "not-available".tr()
                          ],
                          ["rate".tr(), engineer.rate]
                        ])
                          Flexible(
                            child: Row(
                              children: [
                                Flexible(
                                  child: Container(
                                    width: 90,
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Text(
                                      item[0].toString() + ":",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1
                                          ?.copyWith(fontSize: 15),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Align(
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: item[0].toString()=="rate".tr()?Builder(
                                      builder: (context) {
                                        int counter=5-int.parse(item[1].toString());
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            for(int i=0;i<int.parse(item[1].toString());i++)
                                              Icon(Icons.star,color: Colors.yellow,size: 20,),
                                            for(int i=0;i<counter;i++)
                                              Icon(Icons.star,color: Colors.grey,size: 20,),

                                          ],
                                        );
                                      }
                                    ):Text(
                                      item[1].toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1
                                          ?.copyWith(
                                              fontSize: 15,
                                              color: item[1].toString() ==
                                                      "not-available".tr()
                                                  ? Colors.red
                                                  : ColorsApp.primary),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                      ],
                    )),
              ],
            ),
          ),
          if (engineer.isCurrent)
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: InkWell(
                onTap: () {
                  engineerManager.deleteEngineer(engineer.id!);
                },
                child: Container(
                  height: 40,
                  width: 40,
                  margin: EdgeInsetsDirectional.only(
                      end: ConstantValues.padding * 0.5),
                  alignment: Alignment.center,
                  decoration:
                      BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  child: Icon(
                    Icons.remove,
                    size: 30,
                    color: ColorsApp.white,
                  ),
                ),
              ),
            ),
        ],
      );
}
