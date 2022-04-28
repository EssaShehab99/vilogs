import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vilogs/modules/auth.dart';
import 'package:vilogs/styles/theme_app.dart';

import 'data/network/sign_up_dao.dart';
import 'data/providers/app_state_manager.dart';
import 'data/providers/user_manager.dart';
import 'data/setting/config.dart';
import 'modules/new_password.dart';
import 'modules/reset_password.dart';
import 'modules/sign_in.dart';
import 'modules/success_verification.dart';
import 'modules/verification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();

  runApp(EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'SA')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      startLocale: const Locale('en', 'US'),
      saveLocale: true,
      child: MyApp(isInVerification: await Config.getVerification())));
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key,required this.isInVerification}) : super(key: key);
  final bool isInVerification;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppStateManager()),
    ChangeNotifierProvider(create: (context) => UserManager()),
        ChangeNotifierProxyProvider<UserManager, SignUpDAO>(
          create: (context) => SignUpDAO(
              user: Provider.of<UserManager>(context, listen: false).getUser),
          update: (context, userManager, _) =>
              SignUpDAO(user: userManager.getUser),
        ),

    ],
      child: Consumer<AppStateManager>(
        builder: (context, value, child) {
          return MaterialApp(
            home: SafeArea(child:isInVerification?Verification(): Auth()),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            theme: ThemeApp.light,
          );
        },
      ),
    );  }
}
