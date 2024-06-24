import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterchatapp/models/message_model.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance; // auth instance

  //firestore instance
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // Sending a message

  Future<void> sendMessage(String receiverId, String msg, String senderName,
      String receiverName) async {
    // getting the current user
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email!;
    final msgTime = Timestamp.now();

    // creating the message using the message Model
    MessageModel newMsg = MessageModel(
      senderId: currentUserId,
      receiverId: receiverId,
      receiverName: receiverName,
      senderName: senderName,
      senderEmailId: currentUserEmail,
      message: msg,
      msgTime: msgTime,
    );

    // creating a chatroom id using both the users id,
    List<String> userIds = [currentUserId, receiverId];
    // sorting to make sure that same two users always have the same room id.
    userIds.sort();
    String roomId = userIds.join(''); // join returns a string.

    // saving the message to firestore
    await _fireStore
        .collection('chatrooms')
        .doc(roomId)
        .collection('messages')
        .add(newMsg.convertToMap());
  }

  //Receving messages

  Stream<List<MessageModel>> receiveMsges(String receiverId) {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    List<String> userIds = [currentUserId, receiverId];

    // similar as above (making sure roomId remains same for two people)
    userIds.sort();

    String roomId = userIds.join('');

    return _fireStore
        .collection('chatrooms')
        .doc(roomId)
        .collection('messages')
        .orderBy('msgTime', descending: true)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((msg) {
        return MessageModel.fromMap(msg.data());
      }).toList();
    });
  }

  // Stream  receiveMsges(String currentUserId, String otherUserId) {
  //   List<String> userIds = [currentUserId, otherUserId];
  //   userIds
  //       .sort(); // similar as above (making sure roomId remains same for two people)
  //   String roomId = userIds.join('');

  //   return _fireStore
  //       .collection('chatrooms')
  //       .doc(roomId)
  //       .collection('messages')
  //       .orderBy('msgTime', descending: false)
  //       .snapshots();
  // }
}
