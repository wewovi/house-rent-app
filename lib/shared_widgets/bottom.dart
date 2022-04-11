import 'package:flutter/material.dart';

import '../pages/homepage.dart';
import '../pages/myBookies.dart';
import '../pages/profile_page.dart';
import '../pages/settings.dart';

class BottomNav extends StatefulWidget {
  BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;

  void changePage(value) {
    setState(() {
      _currentIndex = value;
    });
  }

  final List<Widget> _pages = [
    HomePage(),
    MyBookies(),
    ProfilePage(),
    Settings(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: const TextStyle(color: Colors.blue),
          unselectedLabelStyle: const TextStyle(color: Colors.blue),
          currentIndex: _currentIndex,
          onTap: changePage,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.blue,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.book_online, color: Colors.blue),
                label: "My Bookies"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person, color: Colors.blue), label: "Profile"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings, color: Colors.blue),
                label: "Settings"),
          ]),
      body: _pages.elementAt(_currentIndex),
    );
  }
}
