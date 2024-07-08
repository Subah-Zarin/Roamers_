

import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String text;
  final String sender;
  final DateTime timestamp;

  Message({required this.text, required this.sender, required this.timestamp});

  factory Message.fromDocument(DocumentSnapshot doc) {
    return Message(
      text: doc['text'],
      sender: doc['sender'],
      timestamp: (doc['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'sender': sender,
      'timestamp': timestamp,
    };
  }
}
