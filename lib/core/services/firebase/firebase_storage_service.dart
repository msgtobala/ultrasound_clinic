import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:ultrasound_clinic/utils/logger/logger.dart';

class FirebaseStorageService {
  // Private constructor
  FirebaseStorageService._privateConstructor();
  final log = CustomLogger.getLogger('FirebaseStorageService');

  // Static instance of the class
  static final FirebaseStorageService _instance =
      FirebaseStorageService._privateConstructor();

  // Factory constructor to return the same instance
  factory FirebaseStorageService() {
    return _instance;
  }

  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadFile(File file, String path, String fileName) async {
    try {
      final ref = _storage.ref().child('$path/$fileName');
      final uploadTask = ref.putFile(file);
      uploadTask.snapshotEvents.listen((event) {
        log.i(
            'Bytes transferred: ${event.bytesTransferred} / ${event.totalBytes}');
        log.i('Task state: ${event.state}');
      });
      final snapshot = await uploadTask.whenComplete(() => null);
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      log.i(e);
      throw Exception('Error uploading file: $e');
    }
  }

  Future<File> downloadFile(String path, File downloadToFile) async {
    try {
      final ref = _storage.ref().child(path);
      await ref.writeToFile(downloadToFile);
      return downloadToFile;
    } catch (e) {
      throw Exception('Error downloading file: $e');
    }
  }

  Future<void> deleteFile(String path) async {
    try {
      final ref = _storage.ref().child(path);
      await ref.delete();
    } catch (e) {
      log.e(e);
      throw Exception('Error deleting file: $e');
    }
  }

  Future<String> getFileUrl(String path) async {
    try {
      final ref = _storage.ref().child(path);
      final downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Error getting file URL: $e');
    }
  }
}
