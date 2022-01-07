import 'package:flutter/material.dart';
import 'package:flutter_installer/core/fi_constants.dart';
import 'package:flutter_installer/core/models/models.dart';
import 'package:flutter_installer/core/router/fi_router.dart';
import 'package:flutter_installer/faq/widgets/question_answer_tile.dart';
import 'package:provider/provider.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 5,
            padding: const EdgeInsets.all(FiConstants.unit),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    "🎈 FAQ",
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () async {
                    await context.read<FIRouter>().pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Back",
                    style: Theme.of(context).textTheme.button?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: FiConstants.faqQuestionAnswerList.length,
              itemBuilder: (BuildContext context, int index) {
                final FaqQuestionAnswer faqQuestionAnswer =
                    FiConstants.faqQuestionAnswerList[index];

                return QuestionAnswerTile(
                  question: faqQuestionAnswer.question,
                  answer: faqQuestionAnswer.answer,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
