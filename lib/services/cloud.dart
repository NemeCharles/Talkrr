import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:text_app/components/enums/message_type.dart';
import 'package:text_app/models/message.dart';
import 'package:text_app/services/storage.dart';
import '../models/message_overview.dart';
import '../models/user.dart';
import '../storage_services/hive_services.dart';
import 'dart:io';


class CloudStore {
  final CollectionReference _userStore = FirebaseFirestore.instance.collection('user');
  final CollectionReference _messageStore = FirebaseFirestore.instance.collection('message');
  final Storage _store = Storage();


  void sendFileMessage (UserData data, File file) async {
    final loggedInUser = HiveServices().getUser();
    final String url = await _store.storeImage(
        file: file,
        reference: '${loggedInUser?.uid}/${data.uid}/images/fileName'
    );
  }

  void sendMessage2 ({required String uid, required String displayName, required String profilePhoto, required String message}) async {
    final loggedInUser = HiveServices().getUser();
    try{
      final user1Messages = await _messageStore.doc(loggedInUser?.uid).collection('dms').doc(uid).withConverter(
          fromFirestore: (snapshot, _) => MsgOverviewModel.fromJSON(snapshot.data()!),
          toFirestore: (msgOverview, _) => msgOverview.toJSON()
      ).get();

      if(user1Messages.exists == false) {
        await _messageStore.doc(loggedInUser?.uid).collection('dms').doc(uid).withConverter(
            fromFirestore: (snapshot, _) => MsgOverviewModel.fromJSON(snapshot.data()!),
            toFirestore: (msgOverview, _) => msgOverview.toJSON()
        ).set(
            MsgOverviewModel(
                receiverDisplayName: displayName,
                receiverDp: profilePhoto,
                receiverUid: uid,
                senderUid: loggedInUser?.uid,
                lastMessage: message,
                messageType: MessageType.text,
                lastTime: Timestamp.now(),
                messageCount: 0
            )
        );
        await _messageStore.doc(uid).collection('dms').doc(loggedInUser?.uid).withConverter(
            fromFirestore: (snapshot, _) => MsgOverviewModel.fromJSON(snapshot.data()!),
            toFirestore: (msgOverview, _) => msgOverview.toJSON()
        ).set(
            MsgOverviewModel(
                receiverDisplayName: loggedInUser?.userName,
                receiverDp: loggedInUser?.profilePhoto,
                receiverUid: loggedInUser?.uid,
                senderUid: uid,
                lastMessage: message,
                messageType: MessageType.text,
                lastTime: Timestamp.now(),
                messageCount: 1
            )
        );

        await _messageStore.doc(loggedInUser?.uid).collection('dms').doc(uid).collection('msg_list').withConverter(
            fromFirestore: (snapshot, _) => MessageModel.fromJSON(snapshot.data()!),
            toFirestore: (messageModel, _) => messageModel.toJSON()
        ).add(
            MessageModel(
                message: message,
                deliveredTime: Timestamp.now(),
                senderUid: loggedInUser?.uid,
                messageType: MessageType.text
            )
        );

        await _messageStore.doc(uid).collection('dms').doc(loggedInUser?.uid).collection('msg_list').withConverter(
            fromFirestore: (snapshot, _) => MessageModel.fromJSON(snapshot.data()!),
            toFirestore: (messageModel, _) => messageModel.toJSON()
        ).add(
            MessageModel(
                message: message,
                deliveredTime: Timestamp.now(),
                senderUid: loggedInUser?.uid,
                messageType: MessageType.text
            )
        );
      } else{
        await _messageStore.doc(loggedInUser?.uid).collection('dms').doc(uid).collection('msg_list').withConverter(
            fromFirestore: (snapshot, _) => MessageModel.fromJSON(snapshot.data()!),
            toFirestore: (messageModel, _) => messageModel.toJSON()
        ).add(
            MessageModel(
                message: message,
                deliveredTime: Timestamp.now(),
                senderUid: loggedInUser?.uid,
                messageType: MessageType.text
            )
        );

        await _messageStore.doc(uid).collection('dms').doc(loggedInUser?.uid).collection('msg_list').withConverter(
            fromFirestore: (snapshot, _) => MessageModel.fromJSON(snapshot.data()!),
            toFirestore: (messageModel, _) => messageModel.toJSON()
        ).add(
            MessageModel(
                message: message,
                deliveredTime: Timestamp.now(),
                senderUid: loggedInUser?.uid,
                messageType: MessageType.text
            )
        );

        final oldMessageCount = await _messageStore.doc(uid).collection('dms').doc(loggedInUser?.uid).withConverter(
            fromFirestore: (snapshot, _) => MsgOverviewModel.fromJSON(snapshot.data()!),
            toFirestore: (msgOverview, _) => msgOverview.toJSON()
        ).get().then((value) {return value.data()!.messageCount;});


        await _messageStore.doc(loggedInUser?.uid).collection('dms').doc(uid).withConverter(
            fromFirestore: (snapshot, _) => MsgOverviewModel.fromJSON(snapshot.data()!),
            toFirestore: (msgOverview, _) => msgOverview.toJSON()
        ).update({
          'last_message': message,
          'timestamp': Timestamp.now(),
          'message_type': MessageType.text.toString()
        });

        await _messageStore.doc(uid).collection('dms').doc(loggedInUser?.uid).withConverter(
            fromFirestore: (snapshot, _) => MsgOverviewModel.fromJSON(snapshot.data()!),
            toFirestore: (msgOverview, _) => msgOverview.toJSON()
        ).update({
          'last_message': message,
          'timestamp': Timestamp.now(),
          'message_type': MessageType.text.toString(),
          'message_count': oldMessageCount! + 1
        });
      }

    }catch(e) {print(e);}
  }
}