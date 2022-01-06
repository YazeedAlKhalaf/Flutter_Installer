import 'package:flutter/material.dart';
import 'package:flutter_installer/customize/widgets/app_checkbox_tile.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildAppCheckboxTile({
    bool value = false,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: AppCheckboxTile(
          title: "title",
          value: value,
          onChanged: (_) {},
        ),
      ),
    );
  }

  group(
    "AppCheckboxTile |",
    () {
      testWidgets(
        "should render correctly.",
        (WidgetTester tester) async {
          await tester.pumpWidget(buildAppCheckboxTile());

          expect(find.byType(AppCheckboxTile), findsOneWidget);
        },
      );

      testWidgets(
        "should find one app check box tile and press it.",
        (WidgetTester tester) async {
          await tester.pumpWidget(buildAppCheckboxTile());

          expect(find.byType(AppCheckboxTile), findsOneWidget);

          await tester.tap(find.byType(AppCheckboxTile));
        },
      );
    },
  );
}
