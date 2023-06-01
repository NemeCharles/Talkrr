import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/enums/message_type.dart';
import '../../models/message.dart';
import '../../models/message_overview.dart';
import '../../services/cloud.dart';
import '../../storage_services/hive_services.dart';

final chatScreenController = Provider.autoDispose<ChatScreenController>((ref) => ChatScreenController(
  messageStore: ref.watch(cloudStorePod)
));
final chatStream = StreamProvider.autoDispose<List<MessageModel>>((ref) => ref.watch(chatScreenController).loadMessages());


class ChatScreenController {

  ChatScreenController({required this.messageStore});
  final CloudStore messageStore;

  late TextEditingController message;
  final CollectionReference _messageStore = FirebaseFirestore.instance.collection('message');
  late ScrollController scrollController;
  String id = '';
  String displayName = '';
  String profilePhoto = '';

  void initialise () async  {
    message = TextEditingController();
    scrollController = ScrollController();
  }
  void clearText() {
    message.clear();
  }
  void disposeControllers () async {
    message.dispose();
    scrollController.dispose();
  }


  void jumpToLastMessage() async {
    await Future.delayed(const Duration(milliseconds: 500));
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if(scrollController.hasClients) {
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 100), curve: Curves.easeOut);
      }
    });
  }

  void assignReceiverInfo({
    required String uid,
    required String receiverName,
    required String profile,
  }) {
    id = uid;
    displayName = receiverName;
    profilePhoto = profile;
  }

  Stream<List<MessageModel>> loadMessages() {
    final loggedInUser = HiveServices().getUser();
    return _messageStore.doc(loggedInUser?.uid).collection('dms').doc(id).collection('msg_list').withConverter(
        fromFirestore: (snapshot, _) => MessageModel.fromJSON(snapshot.data()!),
        toFirestore: (messageModel, _) => messageModel.toJSON()
    ).orderBy('delivered_time').snapshots().asyncMap((event) {
      List<MessageModel> messages = [];
      for(final message in event.docs) {
        messages.add(message.data());
      }
      return messages;
    });
  }

  void resetCount() async {
    final loggedInUser = HiveServices().getUser();
    final messages = await _messageStore.doc(loggedInUser?.uid).collection('dms').doc(id).withConverter(
        fromFirestore: (snapshot, _) => MsgOverviewModel.fromJSON(snapshot.data()!),
        toFirestore: (msgOverview, _) => msgOverview.toJSON()
    ).get();
    if(messages.exists) {
      await _messageStore.doc(loggedInUser?.uid).collection('dms').doc(id).withConverter(
          fromFirestore: (snapshot, _) => MsgOverviewModel.fromJSON(snapshot.data()!),
          toFirestore: (msgOverview, _) => msgOverview.toJSON()
      ).update({
        'message_count': 0
      });
    }
  }

  void sendMessage({
    required String message
}) {
    messageStore.sendMessage2(
        uid: id,
        displayName: displayName,
        profilePhoto: profilePhoto,
        message: message,
        messageType: MessageType.text
    );
    jumpToLastMessage();
  }

  void sendFileMessage({required MessageType messageType, required File file }) {
    messageStore.sendFileMessage(
      uid: id,
      displayName: displayName,
      profilePhoto: profilePhoto,
      messageType: messageType,
      file: file,
    );
    jumpToLastMessage();
  }


}