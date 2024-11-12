import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_quizapp/helper/quiz_helper.dart';
import 'package:flutter_quizapp/model/quiz_model.dart';

class QuizViewModel extends ChangeNotifier {
  final QuizHelper quizHelper;
  List<QuizModel> list = [];
  int currentQuestionIndex = 0;
  bool isLoading = true;
  int score = 0;
  int? selectedAnswer;
  int answeredCount = 0;
  int unansweredCount = 0;
  Timer? questionTimer;
  bool isTimeUp = false;

  QuizViewModel(this.quizHelper) {
    _insertAndFetchData();
  }

  Future<void> _insertAndFetchData() async {
    await quizHelper.clearDatabase(); // Clear database before inserting new data
    await quizHelper.insertSimpleQuestion(); // Insert sample questions
    await _fetchRecord(); // Fetch the inserted records
  }

  Future<void> _fetchRecord() async {
    list = await quizHelper.fetchRecord();
    print("Total questions fetched: ${list.length}");
    isLoading = false;
    notifyListeners();
    _startTimer();
  }

  void _startTimer() {
    // Start a timer for the current question (30 seconds)
    questionTimer = Timer(Duration(seconds: 30), nextQuestion);
  }

  void nextQuestion() {
    if (selectedAnswer != null) {
      answeredCount++;
    } else {
      unansweredCount++;
    }

    if (currentQuestionIndex < list.length - 1) {
      currentQuestionIndex++;
      selectedAnswer = null;
      isTimeUp = false;
      _startTimer(); // Restart timer on question change
    } else {
      questionTimer?.cancel();
      _showPerformanceDashboard();
    }
    notifyListeners();
  }

  void checkAnswer(int selectedOption) {
    selectedAnswer = selectedOption;
    if (selectedOption == list[currentQuestionIndex].correctAnswer) {
      score++;
    }
    answeredCount++;
    isTimeUp = false; // Stop timer when an answer is selected
    questionTimer?.cancel(); // Cancel timer on answer selection
    notifyListeners();
  }

  void _showPerformanceDashboard() {
    // Show performance statistics
    print('Performance Dashboard:');
    print('Total Questions: ${list.length}');
    print('Answered: $answeredCount');
    print('Unanswered: $unansweredCount');
  }

  void resetQuiz() {
    currentQuestionIndex = 0;
    score = 0;
    selectedAnswer = null;
    answeredCount = 0;
    unansweredCount = 0;
    isTimeUp = false;
    questionTimer?.cancel();
    notifyListeners();
  }

  bool isLastQuestion() {
    return currentQuestionIndex == list.length - 1;
  }
}
