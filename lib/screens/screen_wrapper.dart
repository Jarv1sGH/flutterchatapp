import 'package:flutter/material.dart';
import 'package:flutterchatapp/screens/home_screen.dart';
import 'package:flutterchatapp/screens/profile.dart';
import 'package:flutterchatapp/screens/updates.dart';

class ScreenWrapper extends StatefulWidget {
  const ScreenWrapper({super.key});

  @override
  State<ScreenWrapper> createState() => _ScreenWrapperState();
}

class _ScreenWrapperState extends State<ScreenWrapper> {
  int _selectedScreenIndex = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    const Updates(),
    const Profile(),
  ];
  void onNavIconTap(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        onTap: onNavIconTap,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Icon(
                Icons.messenger_rounded,
              ),
            ),
            label: 'chats',
          ),
          BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Icon(
                  Icons.track_changes_outlined,
                ),
              ),
              label: 'Updates'),
          BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Icon(
                  Icons.person,
                  size: 30,
                ),
              ),
              label: 'Account'),
        ],
      ),
    );
  }
}
