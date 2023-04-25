import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:text_app/models/message.dart';
import '../models/message_overview.dart';
import '../models/user.dart';
import '../storage_services/hive_services.dart';

class CloudStore {
  final CollectionReference _userStore = FirebaseFirestore.instance.collection('user');
  final CollectionReference _messageStore = FirebaseFirestore.instance.collection('messages');
  List<UserData> users = <UserData>[];

  loadAllUsers() async {
    final loggedInUser = HiveServices().getUser();
    try {
      await _userStore.withConverter(
          fromFirestore: (snapshot, _) => UserData.fromJson(snapshot.data()!),
          toFirestore: (userData, _) => userData.toJson()
      ).where('uid', isNotEqualTo: loggedInUser?.uid).get().then((value) {
        final user = value.docs;
        users.clear();
        user.map((user) =>
          users.add(user.data())).toList();
        print("Number of users: ${users.length}");
      });
    } catch(e) {print(e);}
  }

  void loadChats () async {
    final loggedInUser = HiveServices().getUser();
    try{
      final chats = await _messageStore.withConverter(
        fromFirestore: (snapshot, _) => MsgOverviewModel.fromJSON(snapshot.data()!),
        toFirestore: (msgOverview, _) => msgOverview.toJSON()
      ).where('sender_uid', isEqualTo: loggedInUser?.uid).get();
    }catch(e){print(e);}
  }

  // collection(messages) -> doc(list of dms) -> field of messageOverview -> collection(msgList) -> doc(list of messages) -> field(messages)

  void sendMessage (UserData data) async {
    final loggedInUser = HiveServices().getUser();
    try{

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
            lastMessage: '',
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
            lastMessage: '',
            lastTime: Timestamp.now()
          )
        );

        await _messageStore.doc(messageView1.id).collection('msg_list').withConverter(
          fromFirestore: (snapshot, _) => MessageModel.fromJSON(snapshot.data()!),
          toFirestore: (messageModel, _) => messageModel.toJSON()
        ).add(
          MessageModel(
            message: 'Hello',
            deliveredTime: Timestamp.now(),
            senderUid: loggedInUser?.uid
          )
        );
        await _messageStore.doc(messageView2.id).collection('msg_list').withConverter(
            fromFirestore: (snapshot, _) => MessageModel.fromJSON(snapshot.data()!),
            toFirestore: (messageModel, _) => messageModel.toJSON()
        ).add(
            MessageModel(
                message: 'Hello',
                deliveredTime: Timestamp.now(),
                senderUid: loggedInUser?.uid
            )
        );
      } else {

        await _messageStore.doc(user1Messages.docs.first.id).collection('msg_list').withConverter(
            fromFirestore: (snapshot, _) => MessageModel.fromJSON(snapshot.data()!),
            toFirestore: (messageModel, _) => messageModel.toJSON()
        ).add(
            MessageModel(
                message: 'Hello',
                deliveredTime: Timestamp.now(),
                senderUid: loggedInUser?.uid
            )
        );
        await _messageStore.doc(user2Messages.docs.first.id).collection('msg_list').withConverter(
            fromFirestore: (snapshot, _) => MessageModel.fromJSON(snapshot.data()!),
            toFirestore: (messageModel, _) => messageModel.toJSON()
        ).add(
            MessageModel(
                message: 'Hello',
                deliveredTime: Timestamp.now(),
                senderUid: loggedInUser?.uid
            )
        );
      }
    }catch(e) {print(e);}
  }

}