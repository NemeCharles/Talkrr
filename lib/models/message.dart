import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/enums/message_type.dart';

class MessageModel {

  MessageModel({this.messageType,this.message, this.deliveredTime, this.senderUid});

  final String? message;
  final Timestamp? deliveredTime;
  final String? senderUid;
  final MessageType? messageType;

  MessageModel.fromJSON(Map<String, dynamic> data) :
      this(
        message: data['message_content'],
        deliveredTime: data['delivered_time'],
        senderUid: data['sender_uid'],
        messageType: (data['message_type'] as String).toEnum()
      );

  Map<String, dynamic> toJSON() {
    return {
      'message_content': message,
      'delivered_time': deliveredTime,
      'sender_uid': senderUid,
      'message_type': messageType!.type
    };
  }
}