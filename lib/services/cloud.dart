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
  final CollectionReference _messageStore = FirebaseFirestore.instance.collection('testMessage');
  final Storage _store = Storage();
  List<UserData> users = <UserData>[];
  String text = 'Hello Neme';

  Future<List<UserData>> loadAllUsers() async {
    final loggedInUser = HiveServices().getUser();
    List<UserData> testList = <UserData>[];
    try {
      await _userStore.withConverter(
          fromFirestore: (snapshot, _) => UserData.fromJson(snapshot.data()!),
          toFirestore: (userData, _) => userData.toJson()
      ).where('uid', isNotEqualTo: loggedInUser?.uid).get().then((value) {
        users.clear();
        testList.clear();
        for (final user in value.docs) {
          testList.add(user.data());
          users.add(user.data());
        }
        print("Number of users: ${users.length}, ${users.first.displayName}");
      });
    } catch(e) {print(e);}
    return testList;
  }

  Future<List<MsgOverviewModel>> loadChats () async {
    final loggedInUser = HiveServices().getUser();
    List<MsgOverviewModel> dms = [];
    try{
      final chats = await _messageStore.withConverter(
        fromFirestore: (snapshot, _) => MsgOverviewModel.fromJSON(snapshot.data()!),
        toFirestore: (msgOverview, _) => msgOverview.toJSON()
      ).where('sender_uid', isEqualTo: loggedInUser?.uid).get();
      print(chats.docs.length);
      dms.clear();
      for(final chat in chats.docs) {
        dms.add(chat.data());
        print(chat.data().lastTime);
      }
    }catch(e){print(e);}
    return dms;
  }

  void sendMessage (UserData data) async {
    final loggedInUser = HiveServices().getUser();
    try{
      // CHECKS TO SEE IF THE 2 USERS HAVE PREVIOUSLY COMMUNICATED
      //IF NOT, A NEW DOCUMENT TO TO STORE THEIR DISCUSSIONS/MESSAGES AS WELL AS THEIR MESSAGE OVERVIEW WILL BE CREATED AND DOC ID RETURNED

      final user1Messages = await _messageStore.withConverter(
        fromFirestore: (snapshot, _) => MsgOverviewModel.fromJSON(snapshot.data()!),
        toFirestore: (msgOverview, _) => msgOverview.toJSON()
      ).where('sender_uid', isEqualTo: loggedInUser?.uid).where('receiver_uid', isEqualTo: data.uid).get();

      final user2Messages = await _messageStore.withConverter(
          fromFirestore: (snapshot, _) => MsgOverviewModel.fromJSON(snapshot.data()!),
          toFirestore: (msgOverview, _) => msgOverview.toJSON()
      ).where('sender_uid', isEqualTo: data.uid ).where('receiver_uid', isEqualTo: loggedInUser?.uid).get();

      if(user1Messages.docs.isEmpty) {
        final messageView1 = await _messageStore.withConverter(
          fromFirestore: (snapshot, _) => MsgOverviewModel.fromJSON(snapshot.data()!),
          toFirestore: (msgOverview, _) => msgOverview.toJSON()
        ).add(
          MsgOverviewModel(
            receiverDisplayName: data.displayName,
            receiverDp: data.profilePhoto,
            receiverUid: data.uid,
            senderUid: loggedInUser?.uid,
            lastMessage: text,
            messageType: MessageType.text,
            lastTime: Timestamp.now()
          )
        );

        final messageView2 = await _messageStore.withConverter(
          fromFirestore: (snapshot, _) => MsgOverviewModel.fromJSON(snapshot.data()!),
          toFirestore: (msgOverview, _) => msgOverview.toJSON()
        ).add(
          MsgOverviewModel(
            receiverDisplayName: loggedInUser?.userName,
            receiverDp: loggedInUser?.profilePhoto,
            receiverUid: loggedInUser?.uid,
            senderUid: data.uid,
            lastMessage: text,
            messageType: MessageType.text,
            lastTime: Timestamp.now()
          )
        );

        // AFTER DOCUMENT IS CREATED, THE msg_list COLLECTION IS CREATED INSIDE THE DOC
        // TO STORE TEXT MESSAGES BETWEEN USERS IN FORM OF DOCUMENTS WITHE AUTO-GENERATED Ids
        await _messageStore.doc(messageView1.id).collection('msg_list').withConverter(
          fromFirestore: (snapshot, _) => MessageModel.fromJSON(snapshot.data()!),
          toFirestore: (messageModel, _) => messageModel.toJSON()
        ).add(
          MessageModel(
            message: text,
            deliveredTime: Timestamp.now(),
            senderUid: loggedInUser?.uid,
            messageType: MessageType.text
          )
        );

        await _messageStore.doc(messageView2.id).collection('msg_list').withConverter(
            fromFirestore: (snapshot, _) => MessageModel.fromJSON(snapshot.data()!),
            toFirestore: (messageModel, _) => messageModel.toJSON()
        ).add(
            MessageModel(
                message: text,
                deliveredTime: Timestamp.now(),
                senderUid: loggedInUser?.uid,
                messageType: MessageType.text
            )
        );

      } else {
        // IF USERS ALREADY HAVE A COMMON DOCUMENT/DM, NEW MESSAGES ARE SENT AND STORED DIRECTLY IN THE msg_list COLLECTION
        // WHILE THE MESSAGE OVERVIEW IS THE UPDATED WITH THE CONTENTS OF THE LATEST MESSAGE

        await _messageStore.doc(user1Messages.docs.first.id).collection('msg_list').withConverter(
            fromFirestore: (snapshot, _) => MessageModel.fromJSON(snapshot.data()!),
            toFirestore: (messageModel, _) => messageModel.toJSON()
        ).add(
            MessageModel(
                message: text,
                deliveredTime: Timestamp.now(),
                senderUid: loggedInUser?.uid,
                messageType: MessageType.text
            )
        );

        await _messageStore.doc(user2Messages.docs.first.id).collection('msg_list').withConverter(
            fromFirestore: (snapshot, _) => MessageModel.fromJSON(snapshot.data()!),
            toFirestore: (messageModel, _) => messageModel.toJSON()
        ).add(
            MessageModel(
                message: text,
                deliveredTime: Timestamp.now(),
                senderUid: loggedInUser?.uid,
                messageType: MessageType.text
            )
        );

        await _messageStore.doc(user1Messages.docs.first.id).update({
          'last_message': text,
          'timestamp': Timestamp.now(),
          'message_type': MessageType.text
        }).catchError((e){print(e);});

        await _messageStore.doc(user2Messages.docs.first.id).update({
          'last_message': text,
          'timestamp': Timestamp.now(),
          'message_type': MessageType.text
        });

      }
    }catch(e) {print(e);}
  }

  void sendFileMessage (UserData data, File file) async {
    final loggedInUser = HiveServices().getUser();
    final String url = await _store.storeImage(
        file: file,
        reference: '${loggedInUser?.uid}/${data.uid}/images/fileName'
    );
  }


}