import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vilogs/data/network/sign_in_dao.dart';
import 'package:vilogs/modules/auth.dart';
import 'package:vilogs/modules/wait_screen.dart';
import 'package:vilogs/styles/colors_app.dart';
import 'package:vilogs/styles/theme_app.dart';

import 'data/network/sign_up_dao.dart';
import 'data/providers/app_state_manager.dart';
import 'data/providers/user_manager.dart';
import 'data/setting/config.dart';
import '/data/models/user.dart' as Model;
import 'modules/Home.dart';
import 'modules/verification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  Config.clearUser();
  runApp(EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'SA')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      startLocale: const Locale('en', 'US'),
      saveLocale: true,
      child: MyApp(
        isInVerification: await Config.getVerification(),
        user: await Config.getUser(),
      )));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.isInVerification, required this.user})
      : super(key: key);
  final bool isInVerification;
  final Model.User? user;

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
        ChangeNotifierProvider(create: (context) => SignInDAO()),
      ],
      child: Consumer<AppStateManager>(
        builder: (context, value, child) {
          UserManager userManager =
              Provider.of<UserManager>(context, listen: false);
          if (user != null) userManager.setUser(user!);
          return MaterialApp(
            home: SafeArea(
                child: isInVerification
                    ? Verification()
                    : FutureBuilder<Model.User?>(
                        future: Provider.of<SignInDAO>(context, listen: false)
                            .signIn(userManager.getUser?.email,
                                userManager.getUser?.password),
                        builder: (context, snapshot) {

                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.waiting:
                            return WaitScreen();
                            default:
                              if (snapshot.hasData && snapshot.data!=null) {
                                userManager.setUser(snapshot.data!);
                                return Home();
                              } else {
                                return Auth();
                              }
                          }

                        },
                      )),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            theme: ThemeApp.light,
          );
        },
      ),
    );
  }
}
