import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel extends StateNotifier<String> {
  UserViewModel() : super('');

  // Load the username from SharedPreferences
  Future<void> loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUsername = prefs.getString('username');
    if (storedUsername != null) {
      state = storedUsername;
    }
  }

  // Save the username to SharedPreferences
  Future<void> setUsername(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    state = username;
  }
}

// Define the provider for Riverpod
final userViewModelProvider = StateNotifierProvider<UserViewModel, String>((ref) {
  return UserViewModel();
});
