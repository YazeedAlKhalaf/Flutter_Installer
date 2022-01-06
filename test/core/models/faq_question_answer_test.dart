import 'package:flutter_installer/core/models/faq_question_answer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    "FaqQuestionAnswer |",
    () {
      test(
        "should create a FaqQuestionAnswer model "
        "and check the values are right.",
        () {
          const FaqQuestionAnswer faqQuestionAnswer = FaqQuestionAnswer(
            question: "question",
            answer: "answer",
          );

          expect(faqQuestionAnswer, isA<FaqQuestionAnswer>());

          expect(faqQuestionAnswer.question, equals("question"));
          expect(faqQuestionAnswer.answer, equals("answer"));
        },
      );
    },
  );
}
