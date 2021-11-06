import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_installer/core/widgets/fi_back_next_buttons.dart';
import 'package:flutter_installer/customize/bloc/customize_bloc.dart';
import 'package:flutter_installer/customize/customize_screen.dart';
import 'package:flutter_installer/customize/widgets/app_checkbox_tile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';

void main() {
  late MockCustomizeBloc _mockCustomizeBloc;

  Widget buildCustomizeScreen() {
    return MaterialApp(
      home: const CustomizeScreen(),
      builder: (
        BuildContext context,
        Widget? child,
      ) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<CustomizeBloc>.value(value: _mockCustomizeBloc)
          ],
          child: child!,
        );
      },
    );
  }

  setUp(() {
    _mockCustomizeBloc = MockCustomizeBloc();

    whenListen(
      _mockCustomizeBloc,
      const Stream<CustomizeState>.empty(),
      initialState: const CustomizeState.unknown(),
    );
  });

  testWidgets(
    "should render correctly.",
    (WidgetTester tester) async {
      await tester.pumpWidget(buildCustomizeScreen());
      await tester.pumpAndSettle();

      expect(find.byType(CustomizeScreen), findsOneWidget);
    },
  );

  testWidgets(
    "should find customize text.",
    (WidgetTester tester) async {
      await tester.pumpWidget(buildCustomizeScreen());
      await tester.pumpAndSettle();

      final Finder customizeTextFinder = find.text("Customize");
      expect(customizeTextFinder, findsOneWidget);
    },
  );

  group("choose installation path", () {
    testWidgets(
      "should find choose installation path text.",
      (WidgetTester tester) async {
        await tester.pumpWidget(buildCustomizeScreen());
        await tester.pumpAndSettle();

        final Finder chooseInstallationPath = find.text(
          "Choose the installation path: (required)",
        );
        expect(chooseInstallationPath, findsOneWidget);
      },
    );

    testWidgets(
      "should find placeholder text for installation path "
      "when installation path is null "
      "and installation path error is null.",
      (WidgetTester tester) async {
        await tester.pumpWidget(buildCustomizeScreen());
        await tester.pumpAndSettle();

        final Finder chooseInstallationPlaceholderText = find.text(
          "e.g. my_awesome_path/for/fluter",
        );
        expect(chooseInstallationPlaceholderText, findsOneWidget);
      },
    );

    testWidgets(
      "should find error text for installation path "
      "and verify its properties "
      "when installation path is null "
      "and installation path error is not null.",
      (WidgetTester tester) async {
        when(() => _mockCustomizeBloc.state).thenReturn(
          const CustomizeState.unknown().copyWith(
            installationPath: null,
            installationPathError: "You must choose an installation path!",
          ),
        );

        await tester.pumpWidget(buildCustomizeScreen());
        await tester.pumpAndSettle();

        final Finder chooseInstallationErrorText = find.text(
          "You must choose an installation path!",
        );
        expect(chooseInstallationErrorText, findsOneWidget);

        final Text chooseInstallationErrorTextWidget = tester.widget(
          chooseInstallationErrorText,
        );
        expect(
          chooseInstallationErrorTextWidget.style?.color,
          equals(Colors.red),
        );
      },
    );

    testWidgets(
      "should find chosen path text for installation path "
      "when installation path is not null "
      "and installation path error is null.",
      (WidgetTester tester) async {
        when(() => _mockCustomizeBloc.state).thenReturn(
          const CustomizeState.unknown().copyWith(
            installationPath: "installationPath",
            installationPathError: null,
          ),
        );

        await tester.pumpWidget(buildCustomizeScreen());
        await tester.pumpAndSettle();

        final Finder chosenPathText = find.text(
          "installationPath",
        );
        expect(chosenPathText, findsOneWidget);
      },
    );

    testWidgets(
      "should find browse button from its text "
      "and click it.",
      (WidgetTester tester) async {
        await tester.pumpWidget(buildCustomizeScreen());
        await tester.pumpAndSettle();

        final Finder browseButtonFinder = find.text(
          "Browse",
        );
        expect(browseButtonFinder, findsOneWidget);

        await tester.tap(browseButtonFinder);
        await tester.pumpAndSettle();

        verify(
          () => _mockCustomizeBloc.add(
            const CustomizeBrowseEvent(),
          ),
        ).called(1);
      },
    );
  });

  group("choose apps you need", () {
    testWidgets(
      "should find choose apps you need text.",
      (WidgetTester tester) async {
        await tester.pumpWidget(buildCustomizeScreen());
        await tester.pumpAndSettle();

        final Finder chooseAppsText = find.text(
          "Choose apps you need: (optional)",
        );
        expect(chooseAppsText, findsOneWidget);
      },
    );

    testWidgets(
      "should find app checkbox tile with text vs code "
      "and click it.",
      (WidgetTester tester) async {
        await tester.pumpWidget(buildCustomizeScreen());
        await tester.pumpAndSettle();

        final Finder appCheckboxTileVsCode = find.ancestor(
          of: find.text("VS Code"),
          matching: find.byType(AppCheckboxTile),
        );
        expect(appCheckboxTileVsCode, findsOneWidget);

        await tester.tap(appCheckboxTileVsCode);
        await tester.pumpAndSettle();

        verify(
          () => _mockCustomizeBloc.add(
            const CustomizeAppClickedEvent(
              isVsCodeSelected: true,
            ),
          ),
        ).called(1);
      },
    );

    testWidgets(
      "should find app checkbox tile with text git "
      "and click it.",
      (WidgetTester tester) async {
        await tester.pumpWidget(buildCustomizeScreen());
        await tester.pumpAndSettle();

        final Finder appCheckboxTileGit = find.ancestor(
          of: find.text("Git"),
          matching: find.byType(AppCheckboxTile),
        );
        expect(appCheckboxTileGit, findsOneWidget);

        await tester.tap(appCheckboxTileGit);
        await tester.pumpAndSettle();

        verify(
          () => _mockCustomizeBloc.add(
            const CustomizeAppClickedEvent(
              isGitSelected: true,
            ),
          ),
        ).called(1);
      },
    );

    testWidgets(
      "should find app checkbox tile with text intellij idea "
      "and click it.",
      (WidgetTester tester) async {
        await tester.pumpWidget(buildCustomizeScreen());
        await tester.pumpAndSettle();

        final Finder appCheckboxTileIntellijIdea = find.ancestor(
          of: find.text("IntelliJ IDEA"),
          matching: find.byType(AppCheckboxTile),
        );
        expect(appCheckboxTileIntellijIdea, findsOneWidget);

        await tester.tap(appCheckboxTileIntellijIdea);
        await tester.pumpAndSettle();

        verify(
          () => _mockCustomizeBloc.add(
            const CustomizeAppClickedEvent(
              isIntellijIdeaSelected: true,
            ),
          ),
        ).called(1);
      },
    );

    testWidgets(
      "should find app checkbox tile with text android studio "
      "and click it.",
      (WidgetTester tester) async {
        await tester.pumpWidget(buildCustomizeScreen());
        await tester.pumpAndSettle();

        final Finder appCheckboxTileAndroidStudio = find.ancestor(
          of: find.text("Android Studio"),
          matching: find.byType(AppCheckboxTile),
        );
        expect(appCheckboxTileAndroidStudio, findsOneWidget);

        await tester.tap(appCheckboxTileAndroidStudio);
        await tester.pumpAndSettle();

        verify(
          () => _mockCustomizeBloc.add(
            const CustomizeAppClickedEvent(
              isAndroidStudioSelected: true,
            ),
          ),
        ).called(1);
      },
    );
  });

  testWidgets(
    "should find fi back next button widget.",
    (WidgetTester tester) async {
      await tester.pumpWidget(buildCustomizeScreen());
      await tester.pumpAndSettle();

      final Finder backNextButtons = find.byType(
        FIBackNextButtons,
      );
      expect(backNextButtons, findsOneWidget);
    },
  );
}
