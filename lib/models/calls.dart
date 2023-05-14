
class CallModel {
  CallModel({
    this.callerName,
    this.callerId,
    required this.isIncoming,
    required this.isVoiceCall,
    this.callerPhoto,
  });

  final String? callerName;
  final String? callerId;
  final bool isIncoming;
  final bool isVoiceCall;
  final String? callerPhoto;

  CallModel.fromJson(Map<String, dynamic> data) :
        this(
        callerName: data['caller_name'],
        callerId: data['caller_id'],
        isIncoming: data['incoming'],
        isVoiceCall: data['is_voicecall'],
        callerPhoto: data['caller_photo']
      );

  Map<String, dynamic> toJson() {
    return {
      'caller_name': callerName ?? 'Anon',
      'caller_id': callerId ?? '',
      'incoming': isIncoming,
      'is_voicecall': isVoiceCall,
      'caller_photo': callerPhoto ?? ''
    };
  }
}