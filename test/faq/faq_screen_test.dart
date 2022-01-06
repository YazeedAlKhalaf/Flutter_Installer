import 'package:flutter/material.dart';
import 'package:flutter_installer/faq/faq_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildFaqScreen() {
    return const MaterialApp(
      home: FaqScreen(),
    );
  }

  group(
    "FaqScreen |",
    () {
      testWidgets(
        "should render correctly",
        (WidgetTester tester) async {
          await tester.pumpWidget(buildFaqScreen());
          await tester.pumpAndSettle();

          expect(find.byType(FaqScreen), findsOneWidget);
        },
      );
    },
  );
}
