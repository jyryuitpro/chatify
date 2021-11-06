import 'package:firebase_storage/firebase_storage.dart';

const String USER_COLLECTION = 'Users';

class CloudStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  CloudStorageService();
}