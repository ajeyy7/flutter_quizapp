import 'package:flutter/material.dart';
import 'package:flutter_quizapp/view_model/auth_vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
   Widget build(BuildContext context, WidgetRef ref) {
    final username = ref.watch(userViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hello, $username', style:const  TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
