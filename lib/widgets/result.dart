import 'package:flutter/material.dart';
import '../userScreens/question_page.dart';
import '../comps/constants.dart';
import '../models/question_model.dart';
import '../widgets/question_widget.dart';
import '../widgets/next_button.dart';
import '../widgets/options.dart';

class ResultBox extends StatelessWidget {
  const ResultBox({
    Key? key,
    required this.score,
    required this.totalQuestions,
  }) : super(key: key);

  final int score;
  final int totalQuestions;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [const Text('Score'), Text('$score / $totalQuestions')],
          )),
    );
  }
}
