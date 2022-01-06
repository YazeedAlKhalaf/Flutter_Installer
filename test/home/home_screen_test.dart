import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:flutter_installer/core/router/fi_router.dart';
import 'package:flutter_installer/home/home_screen.dart';

void main() {
  Widget buildHomeScreen() {
    return MaterialApp(
      home: const HomeScreen(),
      builder: (BuildContext context, Widget? child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<FIRouter>.value(value: FIRouter()),
          ],
          child: child!,
        );
      },
    );
  }

  group(
    "HomeScreen |",
    () {
      testWidgets(
        "should render correctly.",
        (WidgetTester tester) async {
          await tester.pumpWidget(buildHomeScreen());
          await tester.pumpAndSettle();

          expect(find.byType(HomeScreen), findsOneWidget);
        },
      );

      testWidgets(
        "should find flutter logo image "
        "and verify its properties.",
        (WidgetTester tester) async {
          await tester.pumpWidget(buildHomeScreen());
          await tester.pumpAndSettle();

          final Finder flutterLogoFinder = find.byKey(
            HomeScreen.flutterLogoKey,
          );
          expect(flutterLogoFinder, findsOneWidget);

          final Image flutterLogoWidget = tester.widget(
            flutterLogoFinder,
          );
          expect(
            (flutterLogoWidget.image as AssetImage).assetName,
            equals("assets/images/logo_flutter_1080px_clr.png"),
          );
        },
      );

      testWidgets(
        "should find flutter installer logo image "
        "and verify its properties.",
        (WidgetTester tester) async {
          await tester.pumpWidget(buildHomeScreen());
          await tester.pumpAndSettle();

          final Finder flutterInstallerLogoFinder = find.byKey(
            HomeScreen.flutterInstallerLogoKey,
          );
          expect(flutterInstallerLogoFinder, findsOneWidget);

          final Image flutterInstallerLogoWidget = tester.widget(
            flutterInstallerLogoFinder,
          );
          expect(
            (flutterInstallerLogoWidget.image as AssetImage).assetName,
            equals("assets/images/flutter_installer_logo.png"),
          );
          expect(
            flutterInstallerLogoWidget.width,
            equals(100),
          );
        },
      );

      testWidgets(
        "should find 'Flutter Installer' text "
        "and verify its properties.",
        (WidgetTester tester) async {
          await tester.pumpWidget(buildHomeScreen());
          await tester.pumpAndSettle();

          final Finder flutterInstallerTextFinder = find.text(
            "Flutter Installer",
          );
          expect(flutterInstallerTextFinder, findsOneWidget);

          final Text flutterInstallerTextWidget = tester.widget(
            flutterInstallerTextFinder,
          );
          expect(
            flutterInstallerTextWidget.textAlign,
            equals(TextAlign.center),
          );
        },
      );

      testWidgets(
        "should find a button with 'Get Started' text "
        "and press it.",
        (WidgetTester tester) async {
          await tester.pumpWidget(buildHomeScreen());
          await tester.pumpAndSettle();

          final Finder getStartedButtonFinder = find.ancestor(
            of: find.text("Get Started"),
            matching: find.byType(ElevatedButton),
          );
          expect(getStartedButtonFinder, findsOneWidget);

          await tester.tap(getStartedButtonFinder);
        },
      );

      testWidgets(
        "should find a button with 'FAQ' text "
        "and press it "
        "and expect to find FaqScreen.",
        (WidgetTester tester) async {
          await tester.pumpWidget(buildHomeScreen());
          await tester.pumpAndSettle();

          final Finder faqButtonFinder = find.byKey(
            HomeScreen.faqButtonKey,
          );
          expect(faqButtonFinder, findsOneWidget);

          final TextButton faqButtonWidget = tester.widget(
            faqButtonFinder,
          );
          expect(
            faqButtonWidget.runtimeType.toString(),
            equals("_TextButtonWithIcon"),
          );

          await tester.tap(faqButtonFinder);
        },
      );

      testWidgets(
        "should find made using flutter text "
        "and verify its properties.",
        (WidgetTester tester) async {
          await tester.pumpWidget(buildHomeScreen());
          await tester.pumpAndSettle();

          final Finder madeUsingFlutterTextFinder = find.text(
            "Made using Flutter 💙",
          );
          expect(madeUsingFlutterTextFinder, findsOneWidget);

          final Text madeUsingFlutterTextWidget = tester.widget(
            madeUsingFlutterTextFinder,
          );
          expect(
            madeUsingFlutterTextWidget.textAlign,
            equals(TextAlign.center),
          );
        },
      );

      testWidgets(
        "should find some disclaimer text "
        "and verify its properties.",
        (WidgetTester tester) async {
          await tester.pumpWidget(buildHomeScreen());
          await tester.pumpAndSettle();

          final Finder someDisclaimerTextFinder = find.text(
            "Flutter and the related logo are trademarks of Google LLC.\nWe are not endorsed by or affiliated with Google LLC.",
          );
          expect(someDisclaimerTextFinder, findsOneWidget);

          final Text someDisclaimerTextWidget = tester.widget(
            someDisclaimerTextFinder,
          );
          expect(
            someDisclaimerTextWidget.textAlign,
            equals(TextAlign.center),
          );
        },
      );

      testWidgets(
        "should find 3 SizedBox widgets.",
        (WidgetTester tester) async {
          await tester.pumpWidget(buildHomeScreen());
          await tester.pumpAndSettle();

          final Finder sizedBoxWidget = find.byType(SizedBox);
          expect(sizedBoxWidget.evaluate().length, equals(7));
        },
      );
    },
  );
}
