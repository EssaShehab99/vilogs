import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vilogs/constants/constant_images.dart';
import 'package:vilogs/constants/constant_values.dart';

import '../styles/colors_app.dart';

class RealtimeData extends StatefulWidget {
  const RealtimeData({Key? key}) : super(key: key);

  @override
  State<RealtimeData> createState() => _RealtimeDataState();
}

class _RealtimeDataState extends State<RealtimeData> {
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
                          padding: EdgeInsetsDirectional.only(start: ConstantValues.padding*0.5),
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
                        margin: EdgeInsetsDirectional.only(end: ConstantValues.padding*2),
                        child: Text(
                          "realtime-data".tr(),
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
              child: Image.asset(ConstantImage.realtimeData,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fill),
            )
          ],
        ),
      ),
    );
  }
}
