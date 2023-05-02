enum MessageType {
  text('text'),
  image('image'),
  video('video'),
  audio('audio');

  const MessageType(this.type);
  final String type;
}

extension MessageTypeExtension on String {
  MessageType toEnum() {
    switch (this) {
      case 'text':
        return MessageType.text;
      case 'image':
        return MessageType.image;
      case 'video':
        return MessageType.video;
      case 'audio':
        return MessageType.audio;
      default:
        return MessageType.text;
    }
  }
}

