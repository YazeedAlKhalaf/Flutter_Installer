import 'package:flutter_installer/core/models/models.dart';

class FiConstants {
  static const double unit = 15;

  static const List<FaqQuestionAnswer> faqQuestionAnswerList =
      <FaqQuestionAnswer>[
    FaqQuestionAnswer(
      question: "What is Flutter Installer?",
      answer:
          "Flutter Installer is a tool made by Yazeed AlKhalaf for installing Flutter and needed software to your machine or environment.",
    ),
    FaqQuestionAnswer(
      question: "Why use Flutter to build an installer for Flutter?",
      answer:
          "Flutter is great for a lot of things. This is a test to see how well it performs and is a great thing that a framework has the potential to build itself an installer :)",
    ),
    FaqQuestionAnswer(
      question: "Why does the app ask for my Sudo password? (mac only)",
      answer:
          "The app needs it to be able to add Flutter to your PATH and to copy Visual Studio Code to your applications folder.",
    ),
  ];
}
