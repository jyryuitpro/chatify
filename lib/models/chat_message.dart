import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType {
  TEXT,
  IMAGE,
  UNKNOWN,
}

class ChatMessage {
  final String senderID;
  final MessageType type;
  final String content;
  final DateTime sentTime;

  ChatMessage({
    required this.senderID,
    required this.type,
    required this.content,
    required this.sentTime,
  });

  factory ChatMessage.fromJSON(Map<String, dynamic> _json) {
    MessageType _messageType;
    switch (_json["type"]) {
      case "text":
        _messageType = MessageType.TEXT;
        break;
      case "image":
        _messageType = MessageType.IMAGE;
        break;
      default:
        _messageType = MessageType.UNKNOWN;
    }
    return ChatMessage(
      senderID: _json["sender_id"],
      type: _messageType,
      content: _json["content"],
      sentTime: _json["sent_time"].toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    String _messageType;
    switch(type) {
      case MessageType.TEXT:
        _messageType = "text";
        break;
      case MessageType.IMAGE:
        _messageType = "image";
        break;
      default:
        _messageType = "";
    }
    return {
      "sender_id": senderID,
      "type": _messageType,
      "content": content,
      "sent_time": Timestamp.fromDate(sentTime),
    };
  }
}
