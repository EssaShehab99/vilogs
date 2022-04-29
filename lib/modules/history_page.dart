import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vilogs/constants/constant_images.dart';
import 'package:vilogs/constants/constant_values.dart';
import 'package:vilogs/data/models/history.dart';
import 'package:vilogs/data/providers/history_manager.dart';
import 'package:vilogs/shared/components.dart';

import '../styles/colors_app.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    List<History> list =
        Provider
            .of<HistoryManager>(context, listen: false)
            .historyList;
    return Column(
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
              "history".tr(),
              style:
              Theme
                  .of(context)
                  .textTheme
                  .headline1
                  ?.copyWith(fontSize: 30),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: ConstantValues.padding * 1.5,
                ),
                for (History item in list)
                  Components.defaultListTable(list, item, context)
              ],
            ),
          ),
        )
      ],
    );
  }


}
