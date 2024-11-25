import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quizapp/view/pages/profile_page.dart';
import 'package:flutter_quizapp/view/pages/quiz_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  int _currentPageIndex = 0;

  // List of pages to display for each index
  final List<Widget> _pages = [
    const QuizScreen(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.purple,
        key: _bottomNavigationKey,
        index: _currentPageIndex, // Current page index
        items: const <Widget>[
          Icon(
            Icons.quiz,
            size: 30,
            color: Colors.purple,
          ),
          Icon(
            Icons.person,
            size: 30,
            color: Colors.purple,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentPageIndex = index; // Update page index on tap
          });
        },
      ),
      body: _pages[_currentPageIndex], // Display the selected page
    );
  }
}
