import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:vilogs/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("test input text form field", (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    await tester.enterText(
        find.byKey(Key("email_login")), "essa.shehab.dev@gmail.com");
    await tester.pumpAndSettle();
    await tester.enterText(
        find.byKey(Key("password_login")), "essa@1234567");
    await tester.pumpAndSettle();

    await tester.tap(
        find.byKey(Key("login_btn")));
    await tester.pumpAndSettle();

    await tester.pump(Duration(seconds: 3));
  });
}
