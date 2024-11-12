import 'package:flutter_quizapp/helper/quiz_helper.dart';
import 'package:flutter_quizapp/view_model/quiz_vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final quizViewModelProvider = ChangeNotifierProvider((ref) => QuizViewModel(QuizHelper()));
