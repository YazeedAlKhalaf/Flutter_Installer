import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_installer/verify/verify_screen.dart';

void main() {
  Widget buildVerifyScreen({
    String? installationPath,
    bool? isVsCodeSelected,
    bool? isGitSelected,
    bool? isIntellijIdeaSelected,
    bool? isAndroidStudioSelected,
  }) {
    return MaterialApp(
      home: VerifyScreen(
        installationPath: installationPath ?? "installationPath",
        isVsCodeSelected: isVsCodeSelected ?? true,
        isGitSelected: isGitSelected ?? true,
        isIntellijIdeaSelected: isIntellijIdeaSelected ?? true,
        isAndroidStudioSelected: isAndroidStudioSelected ?? true,
      ),
    );
  }

  testWidgets(
    "should render correctly.",
    (WidgetTester tester) async {
      await tester.pumpWidget(buildVerifyScreen());
      await tester.pumpAndSettle();

      expect(find.byType(VerifyScreen), findsOneWidget);
    },
  );

  testWidgets(
    "should find verify text.",
    (WidgetTester tester) async {
      await tester.pumpWidget(buildVerifyScreen());
      await tester.pumpAndSettle();

      final Finder verifyText = find.text(
        "Verify",
      );
      expect(verifyText, findsOneWidget);
    },
  );

  testWidgets(
    "should find this is a summary text.",
    (WidgetTester tester) async {
      await tester.pumpWidget(buildVerifyScreen());
      await tester.pumpAndSettle();

      final Finder thisSummaryText = find.text(
        "🔵 This is a summary of what will be downloaded & installed:",
      );
      expect(thisSummaryText, findsOneWidget);
    },
  );
}
