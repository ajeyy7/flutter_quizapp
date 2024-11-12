import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quizapp/riverpod/riverpod.dart';
import 'package:flutter_quizapp/view_model/dashboard_vm.dart';
import 'package:flutter_quizapp/view_model/quiz_vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizScreen extends ConsumerWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizViewModel = ref.watch(quizViewModelProvider);
    final countDownController = CountDownController(); // Timer controller

    return Scaffold(
      body: quizViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : quizViewModel.list.isEmpty
              ? const Center(child: Text('No data available'))
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 120,
                        decoration: BoxDecoration(color: Colors.purple[500]),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 25,
                              color: Colors.white,
                            ),
                            Text(
                              'Quizzz',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                            Icon(
                              Icons.help,
                              size: 25,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 140,
                          decoration: BoxDecoration(color: Colors.purple[500]),
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
                      ),

                      const SizedBox(height: 30),
                      CircularCountDownTimer(
                        duration: 30,
                        initialDuration: 0,
                        controller: countDownController,
                        width: 80,
                        height: 80,
                        ringColor: Colors.grey[300]!,
                        fillColor: Colors.purpleAccent[100]!,
                        backgroundColor: Colors.purple[500],
                        strokeWidth: 20.0,
                        strokeCap: StrokeCap.round,
                        textStyle: const TextStyle(
                            fontSize: 33.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                        textFormat: CountdownTextFormat.S,
                        isReverse: true,
                        autoStart: true,
                        onStart: () {
                          debugPrint('Countdown Started');
                        },
                        onComplete: () {
                          debugPrint('Countdown Ended');
                          quizViewModel.nextQuestion();
                          countDownController.start(); // Reset timer
                        },
                      ),
                      const SizedBox(height: 20),
                      // Option buttons
                      _buildOptionButton(
                          quizViewModel,
                          quizViewModel
                              .list[quizViewModel.currentQuestionIndex].option1,
                          1,
                          countDownController,
                          context),
                      _buildOptionButton(
                          quizViewModel,
                          quizViewModel
                              .list[quizViewModel.currentQuestionIndex].option2,
                          2,
                          countDownController,
                          context),
                      _buildOptionButton(
                          quizViewModel,
                          quizViewModel
                              .list[quizViewModel.currentQuestionIndex].option3,
                          3,
                          countDownController,
                          context),
                      _buildOptionButton(
                          quizViewModel,
                          quizViewModel
                              .list[quizViewModel.currentQuestionIndex].option4,
                          4,
                          countDownController,
                          context),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
    );
  }

  // Function to build option buttons
  Widget _buildOptionButton(QuizViewModel quizViewModel, String optionText,
      int optionNumber, CountDownController controller, BuildContext context) {
    final isSelected = quizViewModel.selectedAnswer == optionNumber;
    final isCorrectAnswer = optionNumber ==
        quizViewModel.list[quizViewModel.currentQuestionIndex].correctAnswer;
    Color? backgroundColor;

    if (isSelected) {
      backgroundColor = isCorrectAnswer ? Colors.green[300]! : Colors.red[300]!;
    }

    return InkWell(
      onTap: () {
        quizViewModel.checkAnswer(optionNumber);
        controller.pause(); // Pause timer
        Future.delayed(const Duration(seconds: 1), () {
          // Navigate to the next question or show the result page
          if (quizViewModel.isLastQuestion()) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DashBoardPage(
                  totalQuestions: quizViewModel.list.length,
                  correctAnswers: quizViewModel.score,
                ),
              ),
            );
          } else {
            quizViewModel.nextQuestion();
            controller.start(); // Reset timer for the next question
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              color: backgroundColor ?? Colors.purple[100],
              borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: Text(
              optionText,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
