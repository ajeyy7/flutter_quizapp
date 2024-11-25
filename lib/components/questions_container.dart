import 'package:flutter/material.dart';
import 'package:flutter_quizapp/view_model/quiz_vm.dart';

class QuestionContainer extends StatelessWidget {
  const QuestionContainer({
    super.key,
    required this.quizViewModel,
  });

  final QuizViewModel quizViewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 160,
        decoration: BoxDecoration(
            color: Colors.purple[500],
            borderRadius: BorderRadius.circular(9)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Question ${quizViewModel.currentQuestionIndex + 1}/${quizViewModel.list.length}',
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                quizViewModel
                    .list[quizViewModel.currentQuestionIndex]
                    .question,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
