import 'package:cloud_firestore/cloud_firestore.dart';
import '../storage_services/hive_services.dart';
import 'package:text_app/models/calls.dart';


class CallManager {
  final CollectionReference _calls = FirebaseFirestore.instance.collection('calls');

  void endCall() async {
    final loggedInUser = HiveServices().getUser();
    await _calls.doc(loggedInUser!.uid).withConverter(
        fromFirestore: (snapshot, _) => CallModel.fromJson(snapshot.data()!),
        toFirestore: (messageModel, _) => messageModel.toJson()
    ).set(
        CallModel(
            isIncoming: false,
            callerName: 'Nil',
            callerPhoto: 'Nil',
            callerId: 'Nil', isVoiceCall: true
        )
    );
  }

  void receiveCall(bool isVoiceCall) async {
    final loggedInUser = HiveServices().getUser();
    await _calls.doc(loggedInUser!.uid).withConverter(
      fromFirestore: (snapshot, _) => CallModel.fromJson(snapshot.data()!),
      toFirestore: (messageModel, _) => messageModel.toJson()
    ).set(
      CallModel(
        isIncoming: true,
        callerName: 'Name',
        callerPhoto: 'Photo',
        callerId: 'Id',
        isVoiceCall: isVoiceCall
      )
    );
  }

  Stream<DocumentSnapshot<CallModel>> watchForCalls() {
    final loggedInUser = HiveServices().getUser();
    final callStream = _calls.doc(loggedInUser!.uid).withConverter(
        fromFirestore: (snapshot, _) => CallModel.fromJson(snapshot.data()!),
        toFirestore: (messageModel, _) => messageModel.toJson()
    ).snapshots();
    return callStream;
  }

}