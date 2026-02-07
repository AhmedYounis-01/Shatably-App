enum MessageSender { user, bot }

class ChatMessage {
  final String text;
  final MessageSender sender;
  final bool isTyping;
  final String? base64Image;

  ChatMessage({
    required this.text,
    required this.sender,
    this.isTyping = false,
    this.base64Image,
  });
}
