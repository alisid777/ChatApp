import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String senderId = '';
  String senderEmail = '';
  String recieverId = '';
  String message = '';
  Timestamp timestamp;

  MessageModel(
      {required this.senderId,
      required this.senderEmail,
      required this.recieverId,
      required this.message,
      required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'recieverId': recieverId,
      'message': message,
      'timestamp': timestamp
    };
  }
}
