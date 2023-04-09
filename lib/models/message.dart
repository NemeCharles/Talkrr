import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {

  MessageModel({this.message, this.deliveredTime, this.senderUid});

  final String? message;
  final Timestamp? deliveredTime;
  final String? senderUid;

  MessageModel.fromJSON(Map<String, dynamic> data) :
      this(
        message: data['message_content'],
        deliveredTime: data['delivered_time'],
        senderUid: data['sender_uid']
      );

  Map<String, dynamic> toJSON() {
    return {
      'message_content': message,
      'delivered_time': deliveredTime,
      'sender_uid': senderUid
    };
  }
}