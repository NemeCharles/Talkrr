import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/message_overview.dart';
import '../../services/calls.dart';
import '../../storage_services/hive_services.dart';
import '../calls_screen/incoming_call/incoming.dart';

final overLayProvider = Provider<OverlayEntry>((ref) => OverlayEntry(
    builder: (BuildContext context) => const IncomingCallScreen()
));

final homeController = Provider((ref) => HomeScreenController(ref: ref));
final chatCountState = StateProvider<int>((ref) => 0);
final dmStream = StreamProvider<List<MsgOverviewModel>>((ref) => ref.watch(homeController).loadDms());

class HomeScreenController {
  HomeScreenController({required this.ref});
  final Ref ref;
  final CollectionReference _messageStore = FirebaseFirestore.instance.collection('message');


  void listenForCalls(BuildContext context) {
    final callReceiver = ref.watch(callManagerPod).watchForCalls();
    callReceiver.listen((event) {
      if(event.data()!.isIncoming == true) {
        Overlay.of(context).insert(ref.watch(overLayProvider));
        debugPrint('SOMEONE IS CALLING');
      }
      if(event.data()!.isIncoming == false && ref.watch(overLayProvider).mounted) {
        ref.read(overLayProvider).remove();
        debugPrint('CALL ENDED');
      }
    });
  }

  void cancelCall() {
    ref.read(callManagerPod).endCall();
  }

  void acceptCall() {
    ref.read(callManagerPod).receiveCall(true);
  }


  Stream<List<MsgOverviewModel>> loadDms()  {
      final loggedInUser = HiveServices().getUser();
      final stream = _messageStore.doc(loggedInUser!.uid).collection('dms').withConverter(
          fromFirestore: (snapshot, _) => MsgOverviewModel.fromJSON(snapshot.data()!),
          toFirestore: (msgOverview, _) => msgOverview.toJSON()
      ).orderBy('timestamp', descending: true).snapshots().
      asyncMap((event) {
        List<MsgOverviewModel> dms = [];
        for(final chat in event.docs) {
          dms.add(chat.data());
        }
        return dms;
      });
      return stream;
    }

    void chatCount() {
      final loggedInUser = HiveServices().getUser();
      _messageStore.doc(loggedInUser!.uid).collection('dms').withConverter(
          fromFirestore: (snapshot, _) => MsgOverviewModel.fromJSON(snapshot.data()!),
          toFirestore: (msgOverview, _) => msgOverview.toJSON()
      ).where('message_count', isNotEqualTo: 0).snapshots().listen((event) {
        ref.read(chatCountState.notifier).update((state) => state = event.docs.length);
      });
    }
  }
