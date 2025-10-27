// lib/core/services/firebase_storage_service.dart

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FirebaseStorageService {
  final FirebaseStorage _storage;

  // Constructor now receives FirebaseStorage via DI
  FirebaseStorageService(this._storage);

  Future<String> uploadShowBanner(File imageFile, String fileName) async {
    try {
      Reference ref = _storage.ref().child('show-banners').child(fileName);

      UploadTask uploadTask = ref.putFile(
        imageFile,
        SettableMetadata(
          contentType: _getContentType(imageFile.path),
        ),
      );

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        print(
            'Upload progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100}%');
      });

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      print('Image uploaded successfully: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      throw Exception('Failed to upload image: $e');
    }
  }

  Future<void> deleteShowBanner(String imageUrl) async {
    try {
      final Uri uri = Uri.parse(imageUrl);
      final String path = uri.path.split('/o/').last.split('?').first;
      final String decodedPath = Uri.decodeComponent(path);

      Reference ref = _storage.ref().child(decodedPath);
      await ref.delete();
      print('Image deleted successfully: $imageUrl');
    } catch (e) {
      print('Error deleting image: $e');
      throw Exception('Failed to delete image: $e');
    }
  }

  String generateFileName(File imageFile, String showName) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final extension = imageFile.path.split('.').last.toLowerCase();
    final safeShowName = showName.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    return '${timestamp}_$safeShowName.$extension';
  }

  String _getContentType(String filePath) {
    final extension = filePath.split('.').last.toLowerCase();
    switch (extension) {
      case 'png':
        return 'image/png';
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      default:
        return 'image/jpeg';
    }
  }
}
