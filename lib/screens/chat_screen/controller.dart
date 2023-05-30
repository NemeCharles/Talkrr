import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:text_app/models/user.dart';

import '../../models/message.dart';
import '../../models/message_overview.dart';
import '../../storage_services/hive_services.dart';

final chatScreenController = Provider<ChatScreenController>((ref) => ChatScreenController(ref: ref));
final chatStream = StreamProvider.autoDispose<List<MessageModel>>((ref) => ref.watch(chatScreenController).loadMessages());


class ChatScreenController {

  ChatScreenController({required this.ref});
  final Ref ref;

  late TextEditingController message;
  final CollectionReference _messageStore = FirebaseFirestore.instance.collection('message');
  String id = '';
  late ScrollController scrollController;

  // FlutterSoundRecorder? recorder = FlutterSoundRecorder();
  // String? path = '';
  // Timer? timer;

  // final durationState = StateProvider<Duration>((ref) => const Duration());
  // final recordingState = StateProvider<bool>((ref) => false);
  // final cancelledState = StateProvider<bool>((ref) => false);

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


  void jumpToLastMessage() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  void assignId(String data) async {
    id = data;
  }

  Stream<List<MessageModel>> loadMessages() {
    final loggedInUser = HiveServices().getUser();
    return _messageStore.doc(loggedInUser?.uid).collection('dms').doc(id).collection('msg_list').withConverter(
        fromFirestore: (snapshot, _) => MessageModel.fromJSON(snapshot.data()!),
        toFirestore: (messageModel, _) => messageModel.toJSON()
    ).orderBy('delivered_time', descending: true).snapshots().asyncMap((event) {
      List<MessageModel> messages = [];
      for(final message in event.docs) {
        messages.add(message.data());
      }
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
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

  void sendMessage({required String id, required String displayName, required String profilePic}) {

  }


  // void startRecording() async {
  //   final status = await Permission.microphone.request();
  //   if(status != PermissionStatus.granted) {
  //     throw RecordingPermissionException('MICROPHONE PERMISSION NOT GRANTED');
  //   }
  //   Directory tempDir = await getTemporaryDirectory();
  //   path = '${tempDir.path}/voice_note.aac';
  //   await recorder!.startRecorder(toFile: path, codec: Codec.defaultCodec);
  //   ref.read(recordingState.notifier).update((state) => state = true);
  //   startTimer();
  // }
  //
  // void startTimer() {
  //   timer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //     final time = ref.watch(durationState).inSeconds + 1;
  //     Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
  //       ref.read(durationState.notifier).update((state) => state = Duration(seconds: time));
  //       return SizedBox();
  //     },);
  //   });
  // }

}