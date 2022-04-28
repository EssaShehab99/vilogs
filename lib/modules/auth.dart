import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vilogs/modules/sign_in.dart';
import 'package:vilogs/modules/sign_up.dart';
import 'package:vilogs/shared/components.dart';

import '../shared/custom_tabs.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = new TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomTabs(
        tabController: tabController,
          headerTitle: "app-name".tr(),
          firstTabTitle: "sign-in".tr(),
          secondTabTitle: "sign-up".tr(),
          firstTabChild: SignIn(tabController: tabController),
          secondTabChild: SignUp(tabController: tabController)),
    );
  }
}
