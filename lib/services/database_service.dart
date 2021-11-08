import 'package:chatify/models/chat_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String USER_COLLECTION = 'Users';
const String CHAT_COLLECTION = 'Chats';
const String MESSAGES_COLLECTION = 'messages';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  DatabaseService();

  Future<void> createUser(
      String _uid, String _email, String _name, String _imageURL) async {
    print('===== createUser() =====');
    await _db.collection(USER_COLLECTION).doc(_uid).set(
      {
        "email": _email,
        "image": _imageURL,
        "last_active": DateTime.now().toUtc(),
        "name": _name,
      },
    );
  }

  Future<DocumentSnapshot> getUser(String _uid) {
    return _db.collection(USER_COLLECTION).doc(_uid).get();
  }

  Stream<QuerySnapshot> getChatsForUser(String _uid) {
    return _db
        .collection(CHAT_COLLECTION)
        .where('members', arrayContains: _uid)
        .snapshots();
  }

  Future<QuerySnapshot> getLastMessageForChat(String _chatID) {
    return _db
        .collection(CHAT_COLLECTION)
        .doc(_chatID)
        .collection(MESSAGES_COLLECTION)
        .orderBy("sent_time", descending: true)
        .limit(1)
        .get();
  }

  Stream<QuerySnapshot> streamMessagesForChat(String _chatID) {
    return _db
        .collection(CHAT_COLLECTION)
        .doc(_chatID)
        .collection(MESSAGES_COLLECTION)
        .orderBy("sent_time", descending: false)
        .snapshots();
  }

  Future<void> addMessageToChat(String _chatID, ChatMessage _message) async {
    try {
      await _db.collection(CHAT_COLLECTION).doc(_chatID).collection(MESSAGES_COLLECTION).add(_message.toJson());
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> updateChatData(String _chatID, Map<String, dynamic> _data) async {
    try {
      await _db.collection(CHAT_COLLECTION).doc(_chatID).update(_data);
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> updateUserLastSeenTime(String _uid) async {
    try {
      await _db.collection(USER_COLLECTION).doc(_uid).update(
        {
          "last_active": DateTime.now().toUtc(),
        },
      );
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> deleteChat(String _chatID) async {
    try {
      await _db.collection(CHAT_COLLECTION).doc(_chatID).delete();
    } on Exception catch (e) {
      print(e);
    }
  }
}
