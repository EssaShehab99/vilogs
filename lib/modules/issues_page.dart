import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vilogs/constants/constant_images.dart';
import 'package:vilogs/constants/constant_values.dart';
import 'package:vilogs/data/models/history.dart';
import 'package:vilogs/data/providers/history_manager.dart';
import 'package:vilogs/shared/custom_tabs.dart';

import '../data/models/issues.dart';
import '../data/network/default_data_dao.dart';
import '../data/providers/issues_manager.dart';
import '../styles/colors_app.dart';

class IssuesPage extends StatefulWidget {
  const IssuesPage({Key? key}) : super(key: key);

  @override
  State<IssuesPage> createState() => _IssuesPageState();
}

class _IssuesPageState extends State<IssuesPage> {
  @override
  Widget build(BuildContext context) {
    IssuesManager issuesManager =
        Provider.of<IssuesManager>(context, listen: false);
    Provider.of<DefaultDataDAO>(context, listen: false)
        .getIssuesData().then((value) {
      issuesManager.setIssuesList(value);
    });
    return Consumer<IssuesManager>(
      builder: (context, value, child) => CustomTabs(
        headerTitle:  "issues".tr(),
        firstTabTitle: "past".tr(),
        secondTabTitle: "in-progress".tr(),
        firstTabChild: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (Issues item in issuesManager.getPast())
              buildCard(issuesManager.getPast(), item, context)
          ],
        ),
        secondTabChild: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (Issues item in issuesManager.getIsInProgress())
              buildCard(issuesManager.getIsInProgress(), item, context)
          ],
        ),
      ),
    );
  }

  Container buildCard(List<Issues> list, Issues item, BuildContext context) {
    return Container(
            height: 80,
            width: double.infinity,
            margin: EdgeInsets.symmetric(
                horizontal: ConstantValues.padding),
            padding: EdgeInsets.symmetric(
                horizontal: ConstantValues.padding),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                    top: list.first == item
                        ? Radius.circular(ConstantValues.radius * 4)
                        : Radius.zero,
                    bottom: list.last == item
                        ? Radius.circular(ConstantValues.radius * 4)
                        : Radius.zero),
                color: list.indexOf(item).isEven
                    ? ColorsApp.primary.withOpacity(0.5)
                    : ColorsApp.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    flex: 1,
                    child: Text(
                      item.key + ":",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(
                              color: ColorsApp.black,
                              fontWeight: FontWeight.bold),
                    )),
                Flexible(
                    child: Text(
                  item.value,
                  style: Theme.of(context).textTheme.bodyText1,
                )),
              ],
            ),
          );
  }
}
