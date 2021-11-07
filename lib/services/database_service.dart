import 'package:cloud_firestore/cloud_firestore.dart';

const String USER_COLLECTION = 'Users';
const String CHAT_COLLECTION = 'Chats';
const String MESSAGES_COLLECTION = 'Messages';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  DatabaseService();

  Future<void> createUser(
      String _uid, String _email, String _name, String _imageURL) async {
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
}
