import 'package:flutter/material.dart';

import '../styles/colors_app.dart';

class CustomTabs extends StatelessWidget {
  const CustomTabs(
      {Key? key,
      this.firstTabChild,
      this.firstTabTitle,
      this.secondTabChild,
      this.secondTabTitle,
      this.headerTitle,
      this.tabController})
      : super(key: key);
  final String? headerTitle;
  final String? firstTabTitle;
  final String? secondTabTitle;
  final Widget? firstTabChild;
  final Widget? secondTabChild;
  final TabController? tabController;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Builder(
          builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
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
                        child: Column(
                          children: [
                            Text(
                              headerTitle ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  ?.copyWith(fontSize: 30),
                            ),
                            TabBar(
                              controller: tabController,
                              indicatorWeight: 3,
                              tabs: [
                                Text(
                                  firstTabTitle ?? "",
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                                Text(
                                  secondTabTitle ?? "",
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                              ],
                            )
                          ],
                        ),
                      )),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        firstTabChild ?? SizedBox.shrink(),
                        secondTabChild ?? SizedBox.shrink(),
                      ],
                    ),
                  )
                ],
              )),
    );
  }
}
