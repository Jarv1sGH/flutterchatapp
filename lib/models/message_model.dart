import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  const MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.receiverName,
    required this.senderEmailId,
    required this.senderName,
    required this.message,
    required this.msgTime,
  });
  final String senderId;
  final String receiverId;
  final String receiverName;
  final String senderName;
  final String senderEmailId;
  final String message;
  final Timestamp msgTime;

// de serializes the map received from firestore and converts it into MessageModel
  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      receiverName: map['receiverName'],
      senderName: map['senderName'],
      senderEmailId: map['senderEmailId'],
      message: map['message'],
      msgTime: map['msgTime'],
    );
  }

// converting to store the info in firebase firestore
  Map<String, dynamic> convertToMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'receiverName': receiverName,
      'senderName': senderName,
      'senderEmailId': senderEmailId,
      'message': message,
      'msgTime': msgTime,
    };
  }
}
