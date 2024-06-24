import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterchatapp/models/message_model.dart';

class MessageTile extends StatelessWidget {
  MessageTile({super.key, required this.message});
  final MessageModel message;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    bool isUserMsg = message.senderId == _firebaseAuth.currentUser!.uid;
    return Container(
      alignment: isUserMsg ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment:
                isUserMsg ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Text(
                  isUserMsg ? 'You' : message.senderName,
                  style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white60
                          : Colors.black54),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: isUserMsg ? Colors.purple : Colors.green,
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.elliptical(12, 12),
                      topRight: const Radius.elliptical(12, 12),
                      bottomRight: isUserMsg
                          ? const Radius.elliptical(0, 0)
                          : const Radius.elliptical(12, 12),
                      bottomLeft: isUserMsg
                          ? const Radius.elliptical(12, 12)
                          : const Radius.elliptical(0, 0)),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Text(
                    message.message,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
