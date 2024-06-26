import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterchatapp/screens/profile.dart';
import 'package:flutterchatapp/screens/updates.dart';
import 'package:flutterchatapp/services/auth/auth_service.dart';
import 'package:flutterchatapp/components/user_tile.dart';
import 'package:flutterchatapp/screens/chat_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<String?> getCurrentUserUserName() async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    DocumentSnapshot userDoc =
        await _fireStore.collection('users').doc(currentUserId).get();
    if (userDoc.exists) {
      final data = userDoc.data() as Map<String, dynamic>;
      return data['username'];
    }
    return null;
  }

  void navigateToChatScreen(
      String receiverId, String receiversName, String receiverEmail) async {
    String? senderName = await getCurrentUserUserName();
    if (senderName != null) {
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
        return ChatScreen(
          receiverId: receiverId,
          receiversName: receiversName,
          receiverEmail: receiverEmail,
          senderName: senderName,
        );
      }));
    } else {
      // Handling the case where the username might be null
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('An error occured retreiving the data :(')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Chatify'),
            const SizedBox(
              width: 6,
            ),
            Image.asset(
              'assets/images/messageLogo.png',
              width: 30,
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                final authService =
                    Provider.of<AuthService>(context, listen: false);
                authService.logOut();
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: Colors.deepPurple,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.menu,
                size: 28,
                color: Colors.deepPurple,
              )),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(
                  Icons.search,
                  size: 28,
                  color: Colors.deepPurple,
                ),
                filled: true,
                fillColor: const Color.fromARGB(59, 182, 155, 182),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'An Erorr Occured :( ',
                      style: TextStyle(fontSize: 24),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView(
                  children: snapshot.data!.docs.map((doc) {
                    Map<String, dynamic> data = doc.data();
                    if (_firebaseAuth.currentUser!.uid != data['uid']) {
                      return InkWell(
                          onTap: () {
                            navigateToChatScreen(
                                data['uid'], data['username'], data['email']);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            child: UserTile(username: data['username']),
                          ));
                    } else {
                      return Container();
                    }
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
