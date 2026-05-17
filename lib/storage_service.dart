import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {

  final FirebaseStorage storage =
      FirebaseStorage.instance;

  Future<String> subirImagen(
      Uint8List imageBytes) async {

    final String nombreArchivo =
        DateTime.now()
            .millisecondsSinceEpoch
            .toString();

    final ref = storage
        .ref()
        .child("posts")
        .child("$nombreArchivo.jpg");

    await ref.putData(imageBytes);

    return await ref.getDownloadURL();
  }
}