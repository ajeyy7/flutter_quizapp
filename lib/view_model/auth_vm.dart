import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_quizapp/helper/quiz_helper.dart';

class UserViewModel extends ChangeNotifier {
  final QuizHelper quizHelper;
  String _username = '';

  String get username => _username;

  UserViewModel(this.quizHelper);

  // Load the username from the database
  Future<void> loadUsername() async {
    String? storedUsername = await quizHelper.fetchUsername();
    if (storedUsername != null) {
      _username = storedUsername;
    }
    notifyListeners();
  }

  // Save the username to the database
  Future<void> saveUsername(String username) async {
    bool isSaved = await quizHelper.insertUsername(username);
    if (isSaved) {
      _username = username;
      notifyListeners();
    }
  }
}

// Define the provider for Riverpod
final userViewModelProvider = ChangeNotifierProvider<UserViewModel>((ref) {
  return UserViewModel(QuizHelper());
});
