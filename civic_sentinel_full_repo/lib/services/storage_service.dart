import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  final _storage = FirebaseStorage.instance;
  final _uidGen = Uuid();

  Future<String> uploadFile(File file, String folder) async {
    final id = _uidGen.v4();
    final ref = _storage.ref().child('$folder/$id.jpg');
    final task = await ref.putFile(file);
    return await task.ref.getDownloadURL();
  }
}