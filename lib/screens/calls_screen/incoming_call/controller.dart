import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/calls.dart';
import '../../../services/calls.dart';

final callStreamProvider = StreamProvider<DocumentSnapshot<CallModel>>((ref) => ref.watch(callManagerPod).watchForCalls());
final incomingCallController = Provider<IncomingCallController>((ref) => IncomingCallController(ref: ref));

class IncomingCallController {
  IncomingCallController({required this.ref});
  final ProviderRef ref;

  void cancelCall() {
    ref.read(callManagerPod).endCall();
  }

  void acceptCall() {}

}