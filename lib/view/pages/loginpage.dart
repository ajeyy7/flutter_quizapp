import 'package:flutter/material.dart';
import 'package:flutter_quizapp/components/bottom_bar.dart';
import 'package:flutter_quizapp/components/common_textfileds.dart';
import 'package:flutter_quizapp/view_model/auth_vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});
  Future<void> saveUsername(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
  }

  void login(BuildContext context, String username, String password,
      WidgetRef ref) async {
    if (username.isNotEmpty && password.isNotEmpty) {
      await saveUsername(username);
      ref.read(userViewModelProvider.notifier).setUsername(username);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const BottomBar(),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text('Please fill in both fields'),
      ));
    }
  }

  final passController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              const Icon(
                Icons.quiz_outlined,
                size: 100,
              ),
              const SizedBox(height: 30),
              const Text(
                "Welcome User!",
                style: TextStyle(color: Colors.blueGrey),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(18.0),
                child: CommonTextField(
                  labelText: 'Username',
                  controller: nameController,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(18.0),
                child: CommonTextField(
                  labelText: 'Password',
                  controller: passController,
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(left: 200),
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(6)),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        onPressed: () async {
                          login(context, nameController.text.trim(),
                              passController.text.trim(), ref);
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ))),
              ),
              const SizedBox(height: 20),
              const Text("Or continue with"),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Not a member ?"),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Register Now",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black54),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
