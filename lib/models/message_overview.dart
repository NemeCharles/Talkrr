import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/enums/message_type.dart';

class MsgOverviewModel {

  MsgOverviewModel({
  this.receiverDisplayName,
  this.receiverUid,
  this.senderUid,
  this.receiverDp,
  this.lastMessage,
  this.messageType,
  this.lastTime,
  });

  final String? receiverDisplayName;
  final String? receiverUid;
  final String? senderUid;
  final String? receiverDp;
  final String? lastMessage;
  final MessageType? messageType;
  final Timestamp? lastTime;


  MsgOverviewModel.fromJSON(Map<String, dynamic> data) :
      this(
        receiverDisplayName: data['receiver_name'],
        receiverDp: data['receiver_dp'],
        receiverUid: data['receiver_uid'],
        senderUid: data['sender_uid'],
        lastMessage: data['last_message'],
        messageType: (data['message_type'] as String).toEnum(),
        lastTime: data['timestamp']
      );

  Map<String, dynamic> toJSON () {
    return {
      'receiver_name': receiverDisplayName,
      'receiver_dp': receiverDp,
      'receiver_uid': receiverUid,
      'sender_uid': senderUid,
      'last_message': lastMessage,
      'message_type': messageType!.type,
      'timestamp': lastTime
    };
  }
}