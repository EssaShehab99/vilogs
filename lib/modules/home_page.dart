import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:vilogs/constants/constant_images.dart';
import 'package:vilogs/constants/constant_values.dart';
import 'package:vilogs/data/models/history.dart';
import 'package:vilogs/data/providers/history_manager.dart';
import 'package:vilogs/shared/custom_tabs.dart';

import '../data/models/issues.dart';
import '../data/network/default_data_dao.dart';
import '../data/providers/issues_manager.dart';
import '../shared/components.dart';
import '../styles/colors_app.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    IssuesManager issuesManager =
        Provider.of<IssuesManager>(context, listen: false);
    HistoryManager historyManager =
        Provider
            .of<HistoryManager>(context, listen: false);
    Provider.of<DefaultDataDAO>(context, listen: false)
        .getHomeData().then((value) {
      historyManager.setHistory(value);
    });
    return Consumer<HistoryManager>(
      builder: (context, value, child) => CustomTabs(
        headerTitle: "home".tr(),
        firstTabTitle: "recent-date".tr(),
        secondTabTitle: "chart-data".tr(),
        firstTabChild: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(ConstantValues.padding),
                padding: EdgeInsets.all(ConstantValues.padding),
                decoration: BoxDecoration(
                  color: ColorsApp.primary.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(ConstantValues.radius*4)
                ),
                child: Row(children: [
                  Flexible(flex: 0,child: Icon(Icons.warning_amber_outlined,color: ColorsApp.primary,)),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(start: ConstantValues.padding),
                      child: Text(
                        "temp-very-high".tr(),
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: ColorsApp.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],),
              ),
              for (History item in historyManager.historyList)
                Components.defaultListTable(historyManager.historyList, item, context)
            ],
          ),
        ),
        secondTabChild: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                  child: SizedBox(
                height: ConstantValues.padding,
              )),
              Flexible(
                child: SfRadialGauge(
                  axes: [
                    RadialAxis(
                        startAngle: 180,
                        endAngle: 0,
                        interval: 10,
                        canScaleToFit: true,
                        minimum: 0,
                        maximum: 100,
                        ranges: <GaugeRange>[
                          GaugeRange(
                              startValue: 0, endValue: 25, color: Colors.red),
                          GaugeRange(
                              startValue: 25, endValue: 50, color: Colors.orange),
                          GaugeRange(
                              startValue: 50, endValue: 100, color: Colors.green)
                        ],
                        pointers: <GaugePointer>[
                          NeedlePointer(value: 90)
                        ],
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(
                              widget: Container(
                                  child: Text('90.0',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold))),
                              angle: 90,
                              positionFactor: 0.5)
                        ])
                  ],
                  title: GaugeTitle(
                      text: "fuel".tr(),
                      textStyle: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 30)),
                ),
              ),
              Flexible(
                child: Container(
                  width: 250,
                  margin: EdgeInsets.only(top: ConstantValues.padding * 2),
                  alignment: Alignment.center,
                  child: Text(
                    "vehicle-temp".tr(),
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        ?.copyWith(fontSize: 28),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Flexible(
                  child: SizedBox(
                height: ConstantValues.padding,
              )),
              Flexible(
                child: SfRadialGauge(
                  axes: <RadialAxis>[
                    RadialAxis(
                        showLabels: false,
                        showAxisLine: false,
                        showTicks: false,
                        minimum: 0,
                        maximum: 99,
                        startAngle: 180,
                        endAngle: 0,
                        interval: 10,
                        canScaleToFit: true,
                        ranges: <GaugeRange>[
                          GaugeRange(
                              startValue: 0,
                              endValue: 33,
                              color: Color(0xFFFE2A25),
                              sizeUnit: GaugeSizeUnit.factor,
                              labelStyle: GaugeTextStyle(fontSize: 20),
                              startWidth: 0.65,
                              endWidth: 0.65),
                          GaugeRange(
                            startValue: 33,
                            endValue: 66,
                            color: Color(0xFFFFBA00),
                            labelStyle: GaugeTextStyle(fontSize: 20),
                            startWidth: 0.65,
                            endWidth: 0.65,
                            sizeUnit: GaugeSizeUnit.factor,
                          ),
                          GaugeRange(
                            startValue: 66,
                            endValue: 99,
                            color: Color(0xFF00AB47),
                            labelStyle: GaugeTextStyle(fontSize: 20),
                            sizeUnit: GaugeSizeUnit.factor,
                            startWidth: 0.65,
                            endWidth: 0.65,
                          ),
                        ],
                        pointers: <GaugePointer>[
                          NeedlePointer(value: 60)
                        ])
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

/*  Container buildCard(List<Issues> list, Issues item, BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: ConstantValues.padding),
      padding: EdgeInsets.symmetric(horizontal: ConstantValues.padding),
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
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: ColorsApp.black, fontWeight: FontWeight.bold),
              )),
          Flexible(
              child: Text(
            item.value,
            style: Theme.of(context).textTheme.bodyText1,
          )),
        ],
      ),
    );
  }*/
}
