import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {

  final storage = FirebaseStorage.instance;

  Future<String> uploadProfileImage(File file, String fileName) async {

    var snapshot = await storage.ref()
    .child('/profileImages/$fileName')
    .putFile(file);
    

    return await snapshot.ref.getDownloadURL();

  }
}