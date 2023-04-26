import 'package:flutter/material.dart';
import '../comps/constants.dart';

class NextButton extends StatelessWidget {
  const NextButton({Key? key, required this.nextQuestion}) : super(key: key);

  final VoidCallback nextQuestion;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: nextQuestion,
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: neutral,
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: const Text(
            'Next Question',
            textAlign: TextAlign.center,
          )),
    );
  }
}
