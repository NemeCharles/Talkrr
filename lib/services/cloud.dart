import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:text_app/components/enums/message_type.dart';
import 'package:text_app/models/message.dart';
import 'package:text_app/services/storage.dart';
import '../models/message_overview.dart';
import 'package:uuid/uuid.dart';
import '../storage_services/hive_services.dart';
import 'dart:io';


final cloudStorePod = Provider<CloudStore>((ref) => CloudStore(
  fileStore: ref.watch(storagePod)
));

class CloudStore {
  CloudStore({required this.fileStore});

  final CollectionReference _messageStore = FirebaseFirestore.instance
      .collection('message');
  final Storage fileStore;

  void sendFileMessage({
    required String uid,
    required MessageType messageType,
    required String displayName,
    required String profilePhoto,
    required File file
  }) async {
    final loggedInUser = HiveServices().getUser();
    final fileId = const Uuid().v1();
    try {
      switch (messageType) {
        case MessageType.image:
          final String url = await fileStore.storeFileToFirebase(
              file: file,
              reference: 'chats/${loggedInUser?.uid}/$uid/images/$fileId'
          );
          sendMessage(uid: uid,
              displayName: displayName,
              profilePhoto: profilePhoto,
              message: url,
              messageType: MessageType.image
          );
          break;
        case MessageType.video:
          final String url = await fileStore.storeFileToFirebase(
              file: file,
              reference: 'chats/${loggedInUser?.uid}/$uid/videos/$fileId'
          );
          sendMessage(uid: uid,
              displayName: displayName,
              profilePhoto: profilePhoto,
              message: url,
              messageType: MessageType.video
          );
          break;
        case MessageType.audio:
          final String url = await fileStore.storeFileToFirebase(
              file: file,
              reference: 'chats/${loggedInUser?.uid}/$uid/voice_notes/$fileId'
          );
          sendMessage(uid: uid,
              displayName: displayName,
              profilePhoto: profilePhoto,
              message: url,
              messageType: MessageType.audio
          );
          break;
        default:
          final String url = await fileStore.storeFileToFirebase(
              file: file,
              reference: 'chats/${loggedInUser?.uid}/$uid/images/$fileId'
          );
          sendMessage(uid: uid,
              displayName: displayName,
              profilePhoto: profilePhoto,
              message: url,
              messageType: MessageType.image
          );
          break;
      }
    }catch(e) {print(e);}
  }

  void sendMessage({
    required String uid,
    required String displayName,
    required String profilePhoto,
    required MessageType messageType,
    required String message
  }) async {
    final loggedInUser = HiveServices().getUser();
    try {
      final user1Messages = await _messageStore.doc(loggedInUser?.uid)
          .collection('dms').doc(uid)
          .withConverter(
          fromFirestore: (snapshot, _) =>
              MsgOverviewModel.fromJSON(snapshot.data()!),
          toFirestore: (msgOverview, _) => msgOverview.toJSON()
      )
          .get();

      if (user1Messages.exists == false) {
        await _messageStore.doc(loggedInUser?.uid).collection('dms')
            .doc(uid)
            .withConverter(
            fromFirestore: (snapshot, _) =>
                MsgOverviewModel.fromJSON(snapshot.data()!),
            toFirestore: (msgOverview, _) => msgOverview.toJSON()
        )
            .set(
            MsgOverviewModel(
                receiverDisplayName: displayName,
                receiverDp: profilePhoto,
                receiverUid: uid,
                senderUid: loggedInUser?.uid,
                lastMessage: returnMessage(messageType, message),
                messageType: messageType,
                lastTime: Timestamp.now(),
                messageCount: 0
            )
        );
        await _messageStore.doc(uid).collection('dms')
            .doc(loggedInUser?.uid)
            .withConverter(
            fromFirestore: (snapshot, _) =>
                MsgOverviewModel.fromJSON(snapshot.data()!),
            toFirestore: (msgOverview, _) => msgOverview.toJSON()
        ).set(
            MsgOverviewModel(
                receiverDisplayName: loggedInUser?.userName,
                receiverDp: loggedInUser?.profilePhoto,
                receiverUid: loggedInUser?.uid,
                senderUid: uid,
                lastMessage: returnMessage(messageType, message),
                messageType: messageType,
                lastTime: Timestamp.now(),
                messageCount: 1
            )
        );

        await _messageStore.doc(loggedInUser?.uid).collection('dms')
            .doc(uid)
            .collection('msg_list')
            .withConverter(
            fromFirestore: (snapshot, _) =>
                MessageModel.fromJSON(snapshot.data()!),
            toFirestore: (messageModel, _) => messageModel.toJSON()
        ).add(
            MessageModel(
                message: message,
                deliveredTime: Timestamp.now(),
                senderUid: loggedInUser?.uid,
                messageType: messageType
            )
        );

        await _messageStore.doc(uid).collection('dms')
            .doc(loggedInUser?.uid)
            .collection('msg_list')
            .withConverter(
            fromFirestore: (snapshot, _) =>
                MessageModel.fromJSON(snapshot.data()!),
            toFirestore: (messageModel, _) => messageModel.toJSON()
        ).add(
            MessageModel(
                message: message,
                deliveredTime: Timestamp.now(),
                senderUid: loggedInUser?.uid,
                messageType: messageType
            )
        );
      } else {
        await _messageStore.doc(loggedInUser?.uid).collection('dms')
            .doc(uid)
            .collection('msg_list')
            .withConverter(
            fromFirestore: (snapshot, _) =>
                MessageModel.fromJSON(snapshot.data()!),
            toFirestore: (messageModel, _) => messageModel.toJSON()
        ).add(
            MessageModel(
                message: message,
                deliveredTime: Timestamp.now(),
                senderUid: loggedInUser?.uid,
                messageType: messageType
            )
        );

        await _messageStore.doc(uid).collection('dms')
            .doc(loggedInUser?.uid)
            .collection('msg_list')
            .withConverter(
            fromFirestore: (snapshot, _) =>
                MessageModel.fromJSON(snapshot.data()!),
            toFirestore: (messageModel, _) => messageModel.toJSON()
        ).add(
            MessageModel(
                message: message,
                deliveredTime: Timestamp.now(),
                senderUid: loggedInUser?.uid,
                messageType: messageType
            )
        );

        final oldMessageCount = await _messageStore.doc(uid).collection('dms')
            .doc(loggedInUser?.uid).withConverter(
            fromFirestore: (snapshot, _) =>
                MsgOverviewModel.fromJSON(snapshot.data()!),
            toFirestore: (msgOverview, _) => msgOverview.toJSON()
        ).get()
            .then((value) {
          return value.data()!.messageCount;
        });


        await _messageStore.doc(loggedInUser?.uid).collection('dms')
            .doc(uid)
            .withConverter(
            fromFirestore: (snapshot, _) =>
                MsgOverviewModel.fromJSON(snapshot.data()!),
            toFirestore: (msgOverview, _) => msgOverview.toJSON()
        ).update({
          'last_message': returnMessage(messageType, message),
          'timestamp': Timestamp.now(),
          'message_type': messageType.toString()
        });

        await _messageStore.doc(uid).collection('dms')
            .doc(loggedInUser?.uid)
            .withConverter(
            fromFirestore: (snapshot, _) =>
                MsgOverviewModel.fromJSON(snapshot.data()!),
            toFirestore: (msgOverview, _) => msgOverview.toJSON()
        ).update({
          'last_message': returnMessage(messageType, message),
          'timestamp': Timestamp.now(),
          'message_type': messageType.toString(),
          'message_count': oldMessageCount! + 1
        });
      }
    } catch (e) {
      print(e);
    }
  }

  String returnMessage(MessageType messageType, String message) {
    switch (messageType) {
      case MessageType.text:
        return message ;
      case MessageType.image:
        return 'Photo';
      case MessageType.video:
        return 'Video';
      case MessageType.audio:
        return 'Voice Message';
    }
  }
}