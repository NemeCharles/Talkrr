enum MessageType {
  text('text'),
  image('image'),
  video('video'),
  audio('audio');

  const MessageType(this.type);
  final String type;
}

