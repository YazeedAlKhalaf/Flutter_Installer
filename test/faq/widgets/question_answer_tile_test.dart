import 'package:flutter/material.dart';
import 'package:flutter_installer/faq/widgets/question_answer_tile.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildQuestionAnswerTile() {
    return const MaterialApp(
      home: Scaffold(
        body: QuestionAnswerTile(
          question: "question",
          answer: "answer",
        ),
      ),
    );
  }

  group(
    "QuestionAnswerTile |",
    () {
      testWidgets(
        "should render correctly.",
        (WidgetTester tester) async {
          await tester.pumpWidget(buildQuestionAnswerTile());

          expect(find.byType(QuestionAnswerTile), findsOneWidget);
        },
      );

      testWidgets(
        "should find question text.",
        (WidgetTester tester) async {
          await tester.pumpWidget(buildQuestionAnswerTile());

          final Finder questionTextFinder = find.text(
            "Q: question",
          );
          expect(questionTextFinder, findsOneWidget);
        },
      );

      testWidgets(
        "should find answer text.",
        (WidgetTester tester) async {
          await tester.pumpWidget(buildQuestionAnswerTile());

          final Finder answerTextFinder = find.text(
            "A: answer",
          );
          expect(answerTextFinder, findsOneWidget);
        },
      );
    },
  );
}
