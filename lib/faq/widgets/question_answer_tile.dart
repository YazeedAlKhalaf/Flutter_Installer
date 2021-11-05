import 'package:flutter/material.dart';

class QuestionAnswerTile extends StatelessWidget {
  const QuestionAnswerTile({
    Key? key,
    required this.question,
    required this.answer,
  }) : super(key: key);

  final String question;
  final String answer;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "Q: $question",
      ),
      subtitle: Text(
        "A: $answer",
      ),
    );
  }
}
