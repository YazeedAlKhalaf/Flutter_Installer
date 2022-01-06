import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_installer/verify/widgets/verify_item.dart';

void main() {
  Widget buildVerifyItem() {
    return const MaterialApp(
      home: Scaffold(
        body: VerifyItem(
          text: "verify item text",
        ),
      ),
    );
  }

  group(
    "VerifyItem |",
    () {
      testWidgets(
        "should render correctly.",
        (WidgetTester tester) async {
          await tester.pumpWidget(buildVerifyItem());
          await tester.pumpAndSettle();

          expect(find.byType(VerifyItem), findsOneWidget);
        },
      );

      testWidgets(
        "should find one verify item "
        "and verify its properties.",
        (WidgetTester tester) async {
          await tester.pumpWidget(buildVerifyItem());
          await tester.pumpAndSettle();

          final Finder verifyItem = find.byType(
            VerifyItem,
          );
          expect(verifyItem, findsOneWidget);

          final VerifyItem verifyItemWidget = tester.widget(
            verifyItem,
          );
          expect(verifyItemWidget.text, equals("verify item text"));
        },
      );

      testWidgets(
        "should find one verify item "
        "by its text.",
        (WidgetTester tester) async {
          await tester.pumpWidget(buildVerifyItem());
          await tester.pumpAndSettle();

          final Finder verifyItem = find.ancestor(
            of: find.text("  🔹 verify item text"),
            matching: find.byType(VerifyItem),
          );
          expect(verifyItem, findsOneWidget);
        },
      );
    },
  );
}
