import 'package:flutter/material.dart';
import 'package:flutter_quizapp/view/pages/profile_page.dart';
import 'package:flutter_quizapp/view_model/auth_vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_quizapp/view/pages/components/common_textfileds.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final passController = TextEditingController();
  final namecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userViewModel = ref.watch(userViewModelProvider);

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
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: CommonTextField(labelText: 'Username'),
              ),
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: CommonTextField(labelText: 'Password'),
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
                          String username = namecontroller.text;
                          String passwrd = passController.text;

                          if (username.isNotEmpty &&
                              
                              passwrd.isNotEmpty) {
                            await userViewModel
                                .saveUsername(username); // Save username
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ProfilePage()));
                          }

                    
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
