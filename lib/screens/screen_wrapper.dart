import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  Map<String, dynamic>? _userData;

  void onNavIconTap(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    DocumentSnapshot userDoc =
        await _fireStore.collection('users').doc(currentUserId).get();
    if (userDoc.exists) {
      final data = userDoc.data() as Map<String, dynamic>;
      setState(() {
        _userData = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      const HomeScreen(),
      const Updates(),
      _userData != null
          ? Profile(
              imgUrl: _userData!['imgUrl'] ?? 'assets/images/defaultUser.png',
              username: _userData!['username'] ?? '',
              aboutMe: _userData!['aboutMe'] ?? '',
              phone: _userData!['mobileNum'] ?? '',
              email: _userData!['email'] ?? '',
            )
          : Container(),
    ];
    return Scaffold(
      body: screens[_selectedScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        onTap: onNavIconTap,
        currentIndex: _selectedScreenIndex,
        selectedItemColor: const Color.fromARGB(255, 137, 22, 172),
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
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
